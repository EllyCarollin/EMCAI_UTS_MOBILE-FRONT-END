import 'dart:async';
import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/bike/map.dart'; // Updated to cycling result
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CyclingStop extends StatefulWidget {
  const CyclingStop({super.key});

  @override
  _CyclingStopState createState() => _CyclingStopState();
}

class _CyclingStopState extends State<CyclingStop> {
  int seconds = 0; // Waktu yang telah berlalu
  double distance = 0.0; // Jarak yang ditempuh (dalam meter)
  late Timer _durationTimer;

  double calories = 0.0;
  final int weight = 60; // Berat badan pengguna (dalam kg)
  final double calorieFactor = 0.1; // Faktor kalori per menit untuk bersepeda

  // Kecepatan konstan (misalnya, 20 km/jam = 5.56 meter/detik)
  final double speed = 5.56; // Kecepatan dalam meter per detik (20 km/jam)

  @override
  void initState() {
    super.initState();
    _startTimers();
  }

  @override
  void dispose() {
    _durationTimer.cancel();
    super.dispose();
  }

  void _startTimers() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        distance = _calculateDistance(); // Update jarak setiap detik
        calories = _calculateCalories(); // Update kalori setiap detik
      });
    });
  }

  // Menghitung jarak berdasarkan kecepatan dan waktu yang berlalu
  double _calculateDistance() {
    return speed * seconds; // Jarak = Kecepatan * Waktu
  }

  // Menghitung kalori berdasarkan waktu yang berlalu
  double _calculateCalories() {
    double minutes = seconds / 60.0;
    return minutes * weight * calorieFactor;
  }

  // Format durasi dalam menit:detik
  String _formatDuration(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          const FirstRow(),
          const SizedBox(height: 12),
          Expanded(
            child: CyclingStartBox(
              duration: _formatDuration(seconds),
              distance: distance.toStringAsFixed(2) + ' meters',
              calories: calories.toStringAsFixed(1) + ' kkal',
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F1F1),
      title: const Text(
        'Cycling',
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
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.55, // Sesuaikan tinggi gambar agar tidak meluap
      width: double.infinity,
      child: Image.asset('assets/map.png', fit: BoxFit.cover),
    );
  }
}

class CyclingStartBox extends StatelessWidget {
  final String duration;
  final String distance;
  final String calories;

  const CyclingStartBox({
    super.key,
    required this.duration,
    required this.distance,
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
          Text(label, style: textStyle),
          Text(value, style: textStyleBold),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define text styles
    final textStyle = TextStyle(
      fontSize: screenHeight * 0.018,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
    final textStyleBold = TextStyle(
      fontSize: screenHeight * 0.018,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );

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
          // First Row for Duration and Distance
          Row(
            children: [
              Expanded(
                child: buildBox(
                  context,
                  'Duration',
                  duration,
                  textStyle,
                  textStyleBold,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: buildBox(
                  context,
                  'Distance',
                  distance,
                  textStyle,
                  textStyleBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Second Row for Speed and Calories
          Row(
            children: [
              Expanded(
                child: buildBox(
                  context,
                  'Speed',
                  '21.3 Km/H',
                  textStyle,
                  textStyleBold,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: buildBox(
                  context,
                  'Calories',
                  calories,
                  textStyle,
                  textStyleBold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          // Centering both "Stop" and "Setting" buttons in the Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // This centers both buttons
            children: [
              SizedBox(
                width: screenWidth * 0.4,
                child: ElevatedButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.011,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
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
              const SizedBox(width: 15), // Adding space between button and icon
              Container(
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
            ],
          ),
        ],
      ),
    );
  }
}
