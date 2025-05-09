import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutItem extends StatefulWidget {
  final String day;
  final Color color;
  final String title;
  final String description;
  final bool isLast;
  final ValueChanged<bool?> onChanged;
  final bool isChecked;

  const WorkoutItem({
    required this.day,
    required this.color,
    required this.title,
    required this.description,
    required this.isLast,
    required this.onChanged,
    required this.isChecked,
    super.key,
  });

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem>
    with SingleTickerProviderStateMixin {
  late bool isChecked;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _showNotification() {
    _animationController.forward();

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Progress is Complete!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);

    Future.delayed(Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      widget.color.withAlpha((0.8 * 255).toInt()),
                      widget.color,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (!widget.isLast) const SizedBox(height: 25),
              if (!widget.isLast)
                Container(height: 50, width: 2, color: Colors.grey.shade300),
            ],
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
                widget.onChanged(isChecked);

                if (isChecked) {
                  _showNotification();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PlanWo extends StatefulWidget {
  PlanWo({super.key});

  @override
  _PlanWoState createState() => _PlanWoState();
}

class _PlanWoState extends State<PlanWo> {
  final List<Map<String, dynamic>> workouts = [
    {
      'day': 'MON',
      'color': Colors.blue,
      'title': 'Cardio',
      'description': '5 Exercise 45min',
      'isChecked': false,
    },
    {
      'day': 'TUE',
      'color': Colors.orange,
      'title': 'Program',
      'description': '6 Exercise 45min',
      'isChecked': false,
    },
    {
      'day': 'WED',
      'color': Colors.purple,
      'title': 'Cross Fit',
      'description': '5 Exercise 50min',
      'isChecked': false,
    },
    {
      'day': 'THU',
      'color': Colors.green,
      'title': 'Aerobics',
      'description': '5 Exercise 25min',
      'isChecked': false,
    },
    {
      'day': 'FRI',
      'color': Colors.blueAccent,
      'title': 'Yoga',
      'description': '5 Exercise 35min',
      'isChecked': false,
    },
  ];

  void _handleCheckboxChange(int index, bool isChecked) {
    setState(() {
      workouts[index]['isChecked'] = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Plan Workout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Weekly Workout Schedule',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return WorkoutItem(
                    day: workout['day'],
                    color: workout['color'],
                    title: workout['title'],
                    description: workout['description'],
                    isLast: index == workouts.length - 1,
                    isChecked: workout['isChecked'],
                    onChanged: (bool? value) {
                      _handleCheckboxChange(index, value ?? false);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
