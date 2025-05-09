import 'package:fitsync/pages/about/about_us.dart';
import 'package:fitsync/pages/daily/daily.dart';
import 'package:fitsync/pages/homepage/more.dart';
import 'package:fitsync/pages/resource/resource.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitsync/pages/jumprope/start.dart';
import 'package:fitsync/pages/profile/profile.dart';
import 'package:fitsync/pages/historywo/history_wo.dart';
import 'package:fitsync/pages/planwo/plan_wo.dart';
import 'package:fitsync/pages/walking/walking.dart';
import 'package:fitsync/pages/bike/start.dart';
import 'package:fitsync/pages/running/running.dart';
import 'package:fitsync/pages/swimming/start.dart';
import 'package:fitsync/pages/setting/setting.dart';
import 'package:fitsync/pages/edithomepage/edithome.dart';
import 'package:fitsync/pages/noticespage/noticespage.dart';
import 'package:fitsync/pages/promotionspage/promotionspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> favoriteExercises = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList('favorites');

    if (storedFavorites == null || storedFavorites.isEmpty) {
      storedFavorites = ["Walking", "Running", "Bike"];
      await prefs.setStringList('favorites', storedFavorites);
    }

    setState(() {
      favoriteExercises = storedFavorites!.take(3).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 50, height: 50),
            const SizedBox(width: 8),
            const Text(
              'FitSync',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {
              if (value == 'Edit home') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Edithomepage()),
                );
              } else if (value == 'Promotions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Promotionspage(),
                  ),
                );
              } else if (value == 'Notices') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Noticespage()),
                );
              } else if (value == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'Edit home',
                    child: Text('Edit home'),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'Promotions',
                    child: Text('Promotions'),
                  ),
                  const PopupMenuItem(value: 'Notices', child: Text('Notices')),
                  const PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(context),
            const SizedBox(height: 16),
            _buildFavoriteIcons(),
            const SizedBox(height: 16),
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlanWo()),
                  ),
              child: _buildInfoCard(
                title: 'Every great result starts with a plan!',
                subtitle: "Let's build your workout routine.",
                icon: Image.asset('assets/icons/wo_plan.png', height: 50),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  ),
              child: _buildInfoCard(
                title: 'Workout History',
                subtitle: '35:59 Workouts this week',
                icon: const Icon(Icons.history, size: 50, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsPage(),
                    ),
                  ),
              child: _buildInfoCard(
                title: 'About Us',
                subtitle: '....',
                icon: const Icon(
                  Icons.info_outline,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResourcesScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home_active.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/fitness.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile.png', height: 40),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteIcons() {
    Map<String, Widget> routes = {
      'Walking': const Walking(),
      'Running': const Running(),
      'Bike': const CyclingStart(),
      'Jump Rope': const JumpropeStart(),
      'Swimming': const SwimmingStart(),
    };

    Map<String, Widget> icons = {
      'Walking': const Icon(
        Icons.directions_walk,
        size: 30,
        color: Colors.black,
      ),
      'Running': const Icon(
        Icons.directions_run,
        size: 30,
        color: Colors.black,
      ),
      'Bike': const Icon(Icons.directions_bike, size: 30, color: Colors.black),
      'Jump Rope': Image.asset('assets/icons/jump_rope.png', height: 30),
      'Swimming': Image.asset('assets/icons/Swimming.png', height: 30),
      'Running coach': const Icon(Icons.sports, size: 30, color: Colors.black),
      'Hiking': const Icon(Icons.terrain, size: 30, color: Colors.black),
      'Track run': const Icon(
        Icons.track_changes,
        size: 30,
        color: Colors.black,
      ),
      'Pool swim': const Icon(Icons.pool, size: 30, color: Colors.black),
      'Open water swim': const Icon(Icons.water, size: 30, color: Colors.black),
      'Treadmill': const Icon(
        Icons.fitness_center,
        size: 30,
        color: Colors.black,
      ),
      'More': const Icon(Icons.more_horiz, size: 30, color: Colors.black),
    };

    List<String> displayedExercises = favoriteExercises.take(3).toList();

    while (displayedExercises.length < 3) {
      displayedExercises.add("");
    }
    displayedExercises.add("More");

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            displayedExercises.map((exercise) {
              if (exercise == "More") {
                return _buildCategoryButton(
                  context,
                  "More",
                  icons["More"]!,
                  const More(),
                );
              } else if (exercise.isEmpty) {
                return const SizedBox(width: 60);
              } else {
                return _buildCategoryButton(
                  context,
                  exercise,
                  icons[exercise.trim()] ?? const Icon(Icons.fitness_center),
                  routes[exercise.trim()] ?? const More(),
                );
              }
            }).toList(),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DailyActivityPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('assets/icons/steps.png', '2,168', 'steps'),
                const SizedBox(height: 8),
                _buildSummaryRow('assets/icons/clock.png', '23', 'mins'),
                const SizedBox(height: 8),
                _buildSummaryRow('assets/icons/calories.png', '62', 'kcal'),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/love.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String iconPath, String value, String label) {
    return Row(
      children: [
        Image.asset(iconPath, width: 24, height: 24),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 7),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String label,
    Widget icon,
    Widget destination,
  ) {
    return GestureDetector(
      onTap: () async {
        if (label == 'More') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
          loadFavorites();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  static Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required Widget icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
