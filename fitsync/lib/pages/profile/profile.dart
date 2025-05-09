import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:fitsync/pages/resource/resource.dart';
import 'package:fitsync/pages/setting/setting.dart';
import 'package:fitsync/pages/profile/edit_profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'My page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 16),
            _buildProgressTracking(),
            _buildCard(
              'Badges',
              '10,000 steps\n10 Mar 2024',
              'assets/images/badges.png',
            ),
            _buildCard(
              'Personal best',
              '16,000\nMost steps',
              'assets/images/personal.png',
            ),
            _buildWeeklySummary(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResourcesScreen()),
            );
          } else if (index == 2) {}
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/fitness.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile_active.png', height: 40),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: SizedBox(
        height: 180,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'lee Jeno',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTracking() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            title: const Text(
              'Progress Tracking:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.black,
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                _buildProgressItem('Weight', 80, 60),
                _buildProgressItem('Sugar Free', 10, 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, double value, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / total,
          backgroundColor: Colors.grey.shade300,
          color: Colors.blue,
          minHeight: 6,
        ),
        const SizedBox(height: 4),
        Text(
          '$value/$total',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCard(String title, String subtitle, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [Image.asset(imagePath, width: 100, height: 100)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(subtitle),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const ListTile(
        title: Text(
          'Weekly summary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('10-16 March'),
            Row(
              children: [
                Text('Average active time'),
                Spacer(),
                Text('13 mins'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
