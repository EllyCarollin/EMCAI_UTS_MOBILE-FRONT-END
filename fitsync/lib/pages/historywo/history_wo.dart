import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'All Exercises',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildThisWeek(),
                    const SizedBox(height: 16),
                    _buildTodayHeader(),
                    const SizedBox(height: 8),
                    _buildExerciseItem(
                      context,
                      Icons.directions_walk,
                      'Walking',
                      '1.10 Km',
                      '15:32',
                      '16:17',
                    ),
                    _buildExerciseItem(
                      context,
                      Icons.directions_bike,
                      'Cycling',
                      '5.23 Km',
                      '17:22',
                      '18:43',
                    ),
                    _buildExerciseItem(
                      context,
                      Icons.directions_run,
                      'Running',
                      '16 Km',
                      '05:00',
                      '08:19',
                    ),
                    _buildExerciseItem(
                      context,
                      Icons.sports_kabaddi,
                      'Jump Rope',
                      '365 Jump',
                      '09:30',
                      '09:38',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDayColumn('S', '3/23'),
          _buildDayColumn('M', '3/24'),
          _buildTodayColumn('T', '3/25'),
          _buildDayColumn('W', '3/26'),
          _buildDayColumn('T', '3/27'),
          _buildDayColumn('F', '3/28'),
          _buildDayColumn('S', '3/29'),
        ],
      ),
    );
  }

  Widget _buildDayColumn(String day, String date) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTodayColumn(String day, String date) {
    return Flexible(
      // Tambahkan Flexible di sini
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            width: 50,
            height: 70, // Balik ke ukuran lebih kecil biar tidak overflow
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThisWeek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('This Week', style: TextStyle(fontSize: 12)),
            SizedBox(height: 4),
            Text(
              '45:44',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('124 Cal', style: TextStyle(color: Colors.red)),
            Text('3 Sessions'),
          ],
        ),
      ],
    );
  }

  Widget _buildTodayHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Today, Mar 25', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('45:44  124 Cal', style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget _buildExerciseItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String startTime,
    String endTime,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Scaffold()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(startTime, style: const TextStyle(color: Colors.blue)),
                Text(endTime, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
