import 'dart:async';
import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/running/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RunningStop extends StatefulWidget {
  const RunningStop({super.key});

  @override
  _RunningStopState createState() => _RunningStopState();
}

class _RunningStopState extends State<RunningStop> {
  int seconds = 0; // Waktu yang telah berlalu
  double distance = 0.0; // Jarak yang ditempuh (dalam meter)
  late Timer _durationTimer; // Timer untuk durasi
  // Tidak diperlukan lagi _jumpCountTimer, karena kita tidak menghitung jump count lagi.

  double calories = 0.0;
  final int weight = 60; // Berat badan pengguna (dalam kg)
  final double calorieFactor = 0.1; // Faktor kalori per menit untuk lari

  // Kecepatan konstan (misalnya, 5 km/jam = 1.39 meter/detik)
  final double speed = 1.39; // Kecepatan dalam meter per detik (5 km/jam)

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
    // Timer untuk durasi (setiap detik)
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
          RunningStratBox(
            duration: _formatDuration(
              seconds,
            ), // Panggil _formatDuration di sini
            distance:
                distance.toStringAsFixed(2) + ' meters', // Menampilkan jarak
            calories:
                calories.toStringAsFixed(1) + ' kkal', // Menampilkan kalori
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F1F1),
      title: const Text(
        'Running',
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
      height:
          screenHeight * 0.562, // Sesuaikan berapa tinggi yang mau kamu pakai
      width: double.infinity,
      child: Image.asset('assets/maps.png', fit: BoxFit.cover),
    );
  }
}

class RunningStratBox extends StatelessWidget {
  final String duration;
  final String distance; // Mengganti 'jumpCount' menjadi 'distance'
  final String calories;

  const RunningStratBox({
    super.key,
    required this.duration,
    required this.distance, // Ganti 'jumpCount' dengan 'distance'
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
                'Distance', // Mengganti label 'Jump Count' menjadi 'Distance'
                distance, // Menampilkan nilai 'distance'
                textStyle,
                textStyleBold,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBox(context, 'Speed', '21,3 Km/J', textStyle, textStyleBold),
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
                                distance: distance, // Menampilkan jarak
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
