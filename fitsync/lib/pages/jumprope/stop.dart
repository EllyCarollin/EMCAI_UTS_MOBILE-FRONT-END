import 'dart:async';
import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/jumprope/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JumpropeStop extends StatefulWidget {
  const JumpropeStop({super.key});

  @override
  _JumpropeStopState createState() => _JumpropeStopState();
}

class _JumpropeStopState extends State<JumpropeStop> {
  int seconds = 0;
  int jumpCount = 0;
  late Timer _durationTimer;
  late Timer _jumpCountTimer;

  double calories = 0.0;
  final int weight = 60; // Berat badan pengguna (dalam kg)
  final double calorieFactor = 0.1; // Faktor kalori per menit untuk lompat tali

  @override
  void initState() {
    super.initState();
    _startTimers();
  }

  @override
  void dispose() {
    _durationTimer.cancel();
    _jumpCountTimer.cancel();
    super.dispose();
  }

  void _startTimers() {
    // Timer untuk durasi (setiap detik)
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        calories = _calculateCalories(); // Update kalori setiap detik
      });
    });

    // Timer untuk jumlah loncatan (setiap 2 detik)
    _jumpCountTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        jumpCount++; // Update jump count setiap 2 detik
      });
    });
  }

  String _formatDuration(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  double _calculateCalories() {
    double minutes = seconds / 60.0;
    return minutes * weight * calorieFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          const FirstRow(),
          const SizedBox(height: 12),
          JumpRopeStatsBox(
            duration: _formatDuration(
              seconds,
            ), // Panggil _formatDuration di sini
            jumpCount: jumpCount.toString(),
            calories: calories.toStringAsFixed(1) + ' kkal',
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F1F1),
      title: const Text(
        'Jump Rope',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 253, 5, 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 192, 1, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/three-dots.png',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class FirstRow extends StatelessWidget {
  const FirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        color: const Color(0xFFF1F1F1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/jump_rope.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class JumpRopeStatsBox extends StatelessWidget {
  final String duration;
  final String jumpCount;
  final String calories;

  const JumpRopeStatsBox({
    super.key,
    required this.duration,
    required this.jumpCount,
    required this.calories,
  });

  Widget buildBox(
    BuildContext context,
    String label,
    String value,
    TextStyle textStyle,
    TextStyle textStyleBold,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.095,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 5,
      fontWeight: FontWeight.w100,
      color: Colors.black,
    );
    final textStyleBold = const TextStyle(
      fontSize: 1,
      fontWeight: FontWeight.w100,
      color: Colors.black,
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.32,
      margin: EdgeInsets.all(screenHeight * 0.02),
      padding: EdgeInsets.all(screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * 0.03),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBox(context, 'Duration', duration, textStyle, textStyleBold),
              const SizedBox(width: 5),
              buildBox(
                context,
                'Jump Count',
                jumpCount,
                textStyle,
                textStyleBold,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBox(
                context,
                'Speed',
                '70 Jump/Min',
                textStyle,
                textStyleBold,
              ),
              const SizedBox(width: 5),
              buildBox(context, 'Calories', calories, textStyle, textStyleBold),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(flex: 1, child: Container()),
              SizedBox(
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ResultsPage(
                                duration: duration, // Sudah diformat sebelumnya
                                jumpCount: jumpCount, // Jumlah loncatan
                                calories: calories, // Kalori
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9D9D9),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.011,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenHeight * 0.03,
                        ),
                      ),
                    ),
                    child: Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.08),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/setting.svg',
                          height: screenHeight * 0.04,
                          width: screenHeight * 0.04,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
