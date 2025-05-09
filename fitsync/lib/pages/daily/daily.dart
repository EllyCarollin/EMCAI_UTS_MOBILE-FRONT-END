import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class TooltipPainter extends CustomPainter {
  final Color color;
  final int value;

  TooltipPainter(this.color, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.7);
    final path = Path();

    double bubbleHeight = 40;
    double bubbleWidth = 50;
    double bubbleX = (size.width - bubbleWidth) / 2;
    double bubbleY = -38;

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bubbleX, bubbleY, bubbleWidth, bubbleHeight - 6),
        const Radius.circular(8),
      ),
    );

    path.moveTo(bubbleX + bubbleWidth / 2 - 5, bubbleY + bubbleHeight - 6);
    path.lineTo(bubbleX + bubbleWidth / 2, bubbleY + bubbleHeight);
    path.lineTo(bubbleX + bubbleWidth / 2 + 5, bubbleY + bubbleHeight - 6);
    path.close();

    canvas.drawPath(path, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$value',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        bubbleX + (bubbleWidth - textPainter.width) / 2,
        bubbleY + (bubbleHeight - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CalendarPreview extends StatefulWidget {
  final Function(int) onDateSelected;
  final int selectedDate;

  const CalendarPreview({
    Key? key,
    required this.onDateSelected,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _CalendarPreviewState createState() => _CalendarPreviewState();
}

class _CalendarPreviewState extends State<CalendarPreview> {
  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<int> dates = [16, 17, 18, 19, 20, 21, 22];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(days.length, (index) {
          bool isSelected = dates[index] == widget.selectedDate;
          return GestureDetector(
            onTap: () => widget.onDateSelected(dates[index]),
            child: Column(
              children: [
                Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: index == 0 ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isSelected)
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Image.asset('assets/love.png', width: 36, height: 36),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  dates[index].toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: index == 0 ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class DailyActivityPage extends StatefulWidget {
  const DailyActivityPage({Key? key}) : super(key: key);

  @override
  State<DailyActivityPage> createState() => _DailyActivityPageState();
}

class _DailyActivityPageState extends State<DailyActivityPage> {
  int selectedDate = 20;
  late Map<String, dynamic> activityData;

  @override
  void initState() {
    super.initState();
    activityData = generateActivityData();
  }

  Map<String, dynamic> generateActivityData() {
    final random = Random();

    // Total yang akan tampil di atas
    int totalSteps = 2000 + random.nextInt(6000); // 2000 - 8000
    int totalActiveMinutes = 30 + random.nextInt(90); // 30 - 120 mins
    int totalCalories = 100 + random.nextInt(500); // 100 - 600 cal

    // Bagi total ke 24 jam random
    List<int> generateSmoothBreakdown(int total) {
      final random = Random();
      List<double> rough = [
        random.nextDouble() * 2 + 1,
      ]; // mulai dengan angka kecil random

      for (int i = 1; i < 24; i++) {
        double change = (random.nextDouble() - 0.5) * 2; // antara -1 dan +1
        double next = (rough[i - 1] + change).clamp(
          0.5,
          3.0,
        ); // jangan terlalu ekstrim
        rough.add(next);
      }

      // Normalize ke total
      double sum = rough.reduce((a, b) => a + b);
      List<int> smoothed =
          rough.map((e) => ((e / sum) * total).round()).toList();

      // Pastikan hasil jumlahnya tetap total (karena rounding bisa miss dikit)
      int diff = total - smoothed.reduce((a, b) => a + b);
      if (diff != 0 && smoothed.isNotEmpty) {
        smoothed[0] += diff;
      }

      return smoothed;
    }

    return {
      'steps': {
        'total': totalSteps,
        'data': generateSmoothBreakdown(totalSteps),
      },
      'active': {
        'total': totalActiveMinutes,
        'data': generateSmoothBreakdown(totalActiveMinutes),
      },
      'calories': {
        'total': totalCalories,
        'data': generateSmoothBreakdown(totalCalories),
      },
    };
  }

  void onDateSelected(int date) {
    setState(() {
      selectedDate = date;
      activityData = generateActivityData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Daily activity',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg', // Pastikan path-nya sesuai
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context); // Untuk kembali ke halaman sebelumnya
            // Kalau mau langsung ke Homepage:
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Homepage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarPreview(
              selectedDate: selectedDate,
              onDateSelected: onDateSelected,
            ),
            const SizedBox(height: 16),
            _buildHeartChart(),
            const SizedBox(height: 24),
            _buildAllGraphs(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartChart() {
    int steps = activityData['steps']['total'];
    int activeTime = activityData['active']['total'];
    int activityCalories = activityData['calories']['total'];

    // Hitung total burned calories
    int burnedCalories = (activityCalories + (steps * 0.04)).round();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Image.asset('assets/love.png', width: 160, height: 160),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActivityInfo(
                iconPath: 'assets/icons/steps.png',
                value: '$steps',
                label: '/6000',
                title: 'Steps',
              ),
              _buildActivityInfo(
                iconPath: 'assets/icons/clock.png',
                value: '$activeTime',
                label: '/90 mins',
                title: 'Active Time',
              ),
              _buildActivityInfo(
                iconPath: 'assets/icons/calories.png',
                value: '$activityCalories',
                label: '/300 cal',
                title: 'Activity Calories',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey[300], thickness: 1),
          const SizedBox(height: 16),
          _buildInfoRow('Total burned calories', '$burnedCalories cal'),
          const SizedBox(height: 12),
          _buildInfoRow('Distance while active', '1.49 km'),
        ],
      ),
    );
  }

  Widget _buildActivityInfo({
    required String iconPath,
    required String value,
    required String label,
    required String title,
  }) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAllGraphs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGraph('Steps', Colors.green, activityData['steps']['data']),
            const SizedBox(height: 24),
            _buildGraph(
              'Active Time',
              Colors.blue,
              activityData['active']['data'],
            ),
            const SizedBox(height: 24),
            _buildGraph(
              'Activity Calories',
              Colors.red,
              activityData['calories']['data'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph(String title, Color color, List<int> data) {
    const double fixedHeight = 200.0;
    const timestamps = ['0', '6', '12', '18', '(h)'];
    ValueNotifier<int?> selectedBarIndex = ValueNotifier<int?>(null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: fixedHeight,
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder<int?>(
                  valueListenable: selectedBarIndex,
                  builder: (context, selectedIndex, child) {
                    int maxValue = data.reduce((a, b) => a > b ? a : b);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(data.length, (index) {
                        double barHeight =
                            (data[index] / maxValue) * fixedHeight * 0.5;
                        return Expanded(
                          child: GestureDetector(
                            onTap:
                                () =>
                                    selectedBarIndex.value =
                                        selectedBarIndex.value == index
                                            ? null
                                            : index,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (selectedIndex == index)
                                  CustomPaint(
                                    painter: TooltipPainter(color, data[index]),
                                    child: Container(height: 24),
                                  ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 1,
                                  ),
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              const Divider(color: Colors.grey, thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      timestamps
                          .map(
                            (t) =>
                                Text(t, style: const TextStyle(fontSize: 12)),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
