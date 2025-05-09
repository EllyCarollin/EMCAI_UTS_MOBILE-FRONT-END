import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.notifications),
          SizedBox(width: 16),
          Icon(Icons.person),
          SizedBox(width: 16),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: About Us + Logo
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Us",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/logo.png',
                    ), // Ganti dengan path gambar Anda
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _lineWithStartDot(),
            _infoCard(
              icon: Icons.info_outline,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            ),
            _lineWithStartDot(),

            const SizedBox(height: 20),
            const Text(
              "About Us",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit. '
              'Dolores Quibusdam Aspernatur Omnis At Ullam Temporibus '
              'Minima Maxime Nemo Voluptatibus Aliquid Quae Illum Officiis...',
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 30),
            const Text(
              "Our Mission",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _lineWithStartDot(),
            _infoCard(
              icon: Icons.star_border,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            ),
            _lineWithStartDot(),

            const SizedBox(height: 30),
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _lineWithEndDot(),
            const SizedBox(height: 10),
            _socialRow("Instagram", FontAwesomeIcons.instagram),
            _socialRow("Facebook", FontAwesomeIcons.facebook),
            _socialRow("Twitter", FontAwesomeIcons.twitter),
            _lineWithEndDot(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _lineWithStartDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: const [
          Icon(Icons.circle, size: 8),
          SizedBox(width: 4),
          Expanded(child: Divider(thickness: 1, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _lineWithEndDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: const [
          Expanded(child: Divider(thickness: 1, color: Colors.black)),
          SizedBox(width: 4),
          Icon(Icons.circle, size: 8),
        ],
      ),
    );
  }

  Widget _infoCard({required IconData icon, required String text}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Widget _socialRow(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Icon(icon, size: 20),
        ],
      ),
    );
  }
}
