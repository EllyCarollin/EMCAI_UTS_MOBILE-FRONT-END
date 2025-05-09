import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/swimming/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class SwimmingStop extends StatefulWidget {
  const SwimmingStop({super.key});

  @override
  _SwimmingStopState createState() => _SwimmingStopState();
}

class _SwimmingStopState extends State<SwimmingStop> {
  int seconds = 0;
  int calories = 0;

  void updateValues(int newSeconds, int newCalories) {
    setState(() {
      seconds = newSeconds;
      calories = newCalories;
    });
  }

  // ✅ Tambahkan ini di dalam _SwimmingStopState
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F1F1),
      title: const Text(
        'Swimming',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Expanded(child: FirstRow(onUpdate: updateValues)),
          StopButton(seconds: seconds, calories: calories),
        ],
      ),
    );
  }
}

class FirstRow extends StatefulWidget {
  final Function(int seconds, int calories) onUpdate;

  const FirstRow({super.key, required this.onUpdate});

  @override
  _FirstRowState createState() => _FirstRowState();
}

class _FirstRowState extends State<FirstRow> {
  int seconds = 0;
  int calories = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        if (seconds % 5 == 0) {
          calories += 1; // misal setiap 5 detik tambah 1kkal
        }
      });
      widget.onUpdate(seconds, calories);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),

        // Duration Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Container(
            width: screenWidth,
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(screenHeight * 0.03),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Duration',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  formatDuration(seconds),
                  style: TextStyle(
                    fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.03),

        // Calories Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Container(
            width: screenWidth,
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(screenHeight * 0.03),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Calories',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  '$calories kkal',
                  style: TextStyle(
                    fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StopButton extends StatelessWidget {
  final int seconds;
  final int calories;

  const StopButton({Key? key, required this.seconds, required this.calories})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenHeight * 0.035;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.03,
      ),
      child: Container(
        height: screenHeight * 0.08,
        child: Row(
          children: [
            const Expanded(child: SizedBox()),

            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ResultsPage(
                              calories: calories,
                              seconds: seconds,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.14,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                    child: Center(
                      child: Text(
                        'Stop',
                        style: TextStyle(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: iconSize * 1.4,
                    height: iconSize * 1.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(iconSize * 0.3),
                      child: SvgPicture.asset(
                        'assets/icons/setting.svg',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
