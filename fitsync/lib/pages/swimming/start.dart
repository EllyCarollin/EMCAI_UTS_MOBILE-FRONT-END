import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/swimming/stop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwimmingStart extends StatelessWidget {
  const SwimmingStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          const FirstRow(),
          SizedBox(
            height:
                MediaQuery.of(context).size.height *
                0.24, // atau ukuran lainnya
            child: TargetBoxWidget(),
          ),
        ],
      ),
    );
  }

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
            child: Image.asset('assets/images/swimming.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class TargetBoxWidget extends StatelessWidget {
  const TargetBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenHeight * 0.007;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row untuk teks dan ikon panah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "No Target",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/triangle_arrow.svg',
                  width: iconSize,
                  height: iconSize,
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // Deskripsi di bawah
            const Text(
              "Boost your training with a workout target.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.015),

            // Tombol Start
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SwimmingStop(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Start",
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height *
                        0.02, // 3% dari tinggi layar
                    fontWeight: FontWeight.w900,
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
