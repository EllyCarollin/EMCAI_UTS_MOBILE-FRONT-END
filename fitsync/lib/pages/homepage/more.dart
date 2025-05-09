import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  final List<String> allExercises = [
    'Walking',
    'Running',
    'Bike',
    'Jump Rope',
    'Swimming',
    'Running coach  ( ON MAINTENANCE )',
    'Hiking  ( ON MAINTENANCE )',
    'Track run  ( ON MAINTENANCE )',
    'Pool swim  ( ON MAINTENANCE )',
    'Open water swim  ( ON MAINTENANCE )',
    'Treadmill  ( ON MAINTENANCE )',
  ];

  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _toggleFavorite(String exercise) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (favorites.contains(exercise)) {
        favorites.remove(exercise);
      } else {
        if (favorites.length >= 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can only select up to 3 favorite exercises'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        favorites.add(exercise);
      }
    });

    await prefs.setStringList('favorites', favorites);
  }

  @override
  Widget build(BuildContext context) {
    final favs = allExercises.where((e) => favorites.contains(e)).toList();
    final more = allExercises.where((e) => !favorites.contains(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Exercises',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select up to 3 favorite exercises to show on homepage',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (favs.isNotEmpty) _buildSection('Favorites', favs, true),
                _buildSection('More Exercises', more, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> items,
    bool isFavoriteSection,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...items
              .map((e) => _buildExerciseTile(e, isFavoriteSection))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildExerciseTile(String title, bool isFavorite) {
    return GestureDetector(
      onTap: () => _toggleFavorite(title),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _getExerciseIcon(title),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              isFavorite ? Icons.star : Icons.star_outline,
              color: isFavorite ? Colors.amber : Colors.grey.shade600,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getExerciseIcon(String exercise) {
    switch (exercise) {
      case 'Walking':
        return const Icon(Icons.directions_walk, color: Colors.greenAccent);
      case 'Running':
      case 'Track run':
      case 'Treadmill':
        return const Icon(Icons.directions_run, color: Colors.greenAccent);
      case 'Bike':
        return const Icon(Icons.directions_bike, color: Colors.greenAccent);
      case 'Jump Rope':
        return const Icon(Icons.skip_next, color: Colors.greenAccent);
      case 'Swimming':
      case 'Pool swim':
      case 'Open water swim':
        return const Icon(Icons.pool, color: Colors.greenAccent);
      case 'Hiking':
        return const Icon(Icons.terrain, color: Colors.greenAccent);
      default:
        return const Icon(Icons.fitness_center, color: Colors.greenAccent);
    }
  }
}
