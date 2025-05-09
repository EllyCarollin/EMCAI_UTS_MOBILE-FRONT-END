import 'package:fitsync/pages/bike/map.dart';
import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultsPageChart extends StatelessWidget {
  final String duration;
  final String distance;
  final String calories;

  const ResultsPageChart({
    Key? key,
    required this.duration,
    required this.distance,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
                    'assets/sepeda.jpg',
                    width: double.infinity,
                    height: screenHeight * 0.35,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Workout Details", style: _valueStyleBlack),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                      const SizedBox(height: 16),

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
                            child: Text('4.2 Km/H', style: _valueStyleBlue),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Workout Calories",
                              style: _subtitleStyle,
                            ),
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
                            child: Text(calories, style: _valueStyleRed),
                          ),
                          Expanded(
                            child: Text('18:14', style: _valueStyleBlue),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Text("Avg. Pace", style: _subtitleStyle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text('14\'04"/Km', style: _valueStyleBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ResultsPage(
                                            duration: duration,
                                            distance: distance,
                                            calories: calories,
                                          ),
                                    ),
                                  );
                                },
                                child: Text('Map', style: _subtitleStyle),
                              ),
                            ],
                          ),

                          const SizedBox(width: 20),

                          Column(
                            children: [
                              Text('Chart', style: _titleStyle),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 2,
                                width: 40,
                                color: Colors.black,
                              ),
                            ],
                          ),

                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),

                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/bagan.jpg',
                          width: double.infinity,
                          height: screenHeight * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                '31.0°C ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              Image.asset(
                                'assets/images/weather.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/water.png',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '73%',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/wind.png',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '20.0Km/h',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/compass.png',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'N.O',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
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
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

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
