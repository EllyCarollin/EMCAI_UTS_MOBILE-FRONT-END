import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/walking/walking_resultsChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalkingResultsPage extends StatelessWidget {
  final String duration;
  final String distance;
  final String calories;

  const WalkingResultsPage({
    Key? key,
    required this.duration,
    required this.distance,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/walking_person.jpg',
                    width: double.infinity,
                    height: screenHeight * 0.35,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_walk,
                          size: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1.10 Km',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Tue, 25 Mar 2025 15:32 – 16:17',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back-arrow.svg',
                        width: 30,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Image.asset(
                      'assets/icons/three-dots.png',
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workout Details + Icon (sendiri di atas)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Workout Details", style: _valueStyleBlack),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Workout Duration + Avg Speed (baru muncul)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Workout Duration",
                              style: _subtitleStyle,
                            ),
                          ),
                          Expanded(
                            child: Text("Avg. Speed", style: _subtitleStyle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(duration, style: _valueStyleBlue),
                          ),
                          Expanded(
                            child: Text('4.0 Km/H', style: _valueStyleBlue),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Workout Calories + Steps
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Workout Calories",
                              style: _subtitleStyle,
                            ),
                          ),
                          Expanded(child: Text("Steps", style: _subtitleStyle)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(calories, style: _valueStyleRed),
                          ),
                          Expanded(
                            child: Text('1,200', style: _valueStyleGreen),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Avg Pace + Total Duration
                      Row(
                        children: [
                          Expanded(
                            child: Text("Avg. Pace", style: _subtitleStyle),
                          ),
                          Expanded(
                            child: Text(
                              "Total Duration",
                              style: _subtitleStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text('14\'04"/Km', style: _valueStyleBlue),
                          ),
                          Expanded(
                            child: Text(duration, style: _valueStyleBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildMapChart(context),
              const SizedBox(height: 20),
              _buildWeather(),
              const SizedBox(height: 20),
              _buildNotes(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow(String title) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: _valueStyleBlack),
      const Icon(Icons.arrow_forward_ios, size: 14),
    ],
  );

  Widget _buildStatRow(String left, String right) => Row(
    children: [
      Expanded(child: Text(left, style: _subtitleStyle)),
      Expanded(child: Text(right, style: _subtitleStyle)),
    ],
  );

  Widget _buildValueRow(String left, String right) => Row(
    children: [
      Expanded(child: Text(left, style: _valueStyleBlue)),
      Expanded(child: Text(right, style: _valueStyleBlue)),
    ],
  );

  Widget _buildMapChart(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text('Map', style: _titleStyle),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 2,
                    width: 40,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WalkingResultsPageChart(
                            duration: duration,
                            distance: distance,
                            calories: calories,
                          ),
                    ),
                  );
                },
                child: Text('Chart', style: _subtitleStyle),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/result_map.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildWeather() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weather',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    '30.0°C',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Image.asset(
                    'assets/images/weather.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _weatherRow('assets/images/water.png', '70%'),
              _weatherRow('assets/images/wind.png', '12.0Km/h'),
              _weatherRow('assets/images/compass.png', 'S.E'),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _weatherRow(String iconPath, String value) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(iconPath, width: 18, height: 18),
      const SizedBox(width: 6),
      Text(value, style: const TextStyle(color: Colors.black54)),
    ],
  );

  Widget _buildNotes() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/notes.png',
            width: 24,
            height: 24,
            color: Colors.black54,
          ),
          const SizedBox(width: 10),
          const Text(
            'Notes',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    ),
  );

  TextStyle get _subtitleStyle =>
      const TextStyle(fontSize: 16, color: Colors.grey);
  TextStyle get _valueStyleBlue => const TextStyle(
    fontSize: 16,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  TextStyle get _valueStyleRed => const TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  TextStyle get _valueStyleGreen => const TextStyle(
    fontSize: 16,
    color: Colors.green,
    fontWeight: FontWeight.bold,
  );
  TextStyle get _valueStyleBlack => const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  TextStyle get _titleStyle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
}
