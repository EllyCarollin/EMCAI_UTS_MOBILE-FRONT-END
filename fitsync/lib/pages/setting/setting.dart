import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool syncWithAccount = true;
  bool marketingNotifications = true;
  bool togetherEnabled = true;
  bool autoDetectWorkouts = true;
  bool consentHealthData = true;
  bool locationInfo = true;

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }

  Widget buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(color: Colors.white, child: Column(children: children)),
      ),
    );
  }

  Widget buildListGroup(List<Widget> tiles) {
    final List<Widget> children = [];
    for (int i = 0; i < tiles.length; i++) {
      children.add(tiles[i]);
      if (i != tiles.length - 1) {
        children.add(const Divider(height: 1));
      }
    }
    return Column(children: children);
  }

  Widget buildListItem(
    String title, {
    String? subtitle,
    Widget? trailing,
    bool tappable = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: tappable ? () => debugPrint('Tapped: $title') : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "FitSync settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          buildCard([
            buildListGroup([
              buildListItem("FitSync account", subtitle: "FitSync@gmail.com"),
              buildListItem(
                "Sync with FitSync account",
                subtitle: "Last synced on March 15 at 14:39",
                trailing: Switch(
                  value: syncWithAccount,
                  onChanged: (val) {
                    setState(() => syncWithAccount = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
            ]),
          ]),

          buildSectionTitle("General"),
          buildCard([
            buildListGroup([
              buildListItem("Units of measurement"),
              buildListItem("Notifications"),
              buildListItem(
                "Marketing Notifications",
                subtitle: "Get notifications from FitSync Health.",
                trailing: Switch(
                  value: marketingNotifications,
                  onChanged: (val) {
                    setState(() => marketingNotifications = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
              buildListItem("Accessories"),
            ]),
          ]),

          buildSectionTitle("Together"),
          buildCard([
            buildListGroup([
              buildListItem(
                "Together",
                subtitle:
                    "Compete in step challenges and compare your step count with friends and people around the world.",
                trailing: Switch(
                  value: togetherEnabled,
                  onChanged: (val) {
                    setState(() => togetherEnabled = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
            ]),
          ]),

          buildSectionTitle("Advanced"),
          buildCard([
            buildListGroup([
              buildListItem(
                "Auto detect workouts",
                trailing: Switch(
                  value: autoDetectWorkouts,
                  onChanged: (val) {
                    setState(() => autoDetectWorkouts = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
            ]),
          ]),

          buildSectionTitle("Connected apps and services"),
          buildCard([
            buildListGroup([
              buildListItem(
                "Apps",
                subtitle:
                    "Allow FitSync Health functions and third-party apps to read and write specific data.",
              ),
              buildListItem(
                "Services",
                subtitle:
                    "Sync FitSync Health data with third-party web accounts.",
              ),
            ]),
          ]),

          buildSectionTitle("Privacy"),
          buildCard([
            buildListGroup([
              buildListItem(
                "Consent to the processing of health data",
                trailing: Switch(
                  value: consentHealthData,
                  onChanged: (val) {
                    setState(() => consentHealthData = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
              buildListItem(
                "Location information",
                trailing: Switch(
                  value: locationInfo,
                  onChanged: (val) {
                    setState(() => locationInfo = val);
                  },
                  activeColor: Colors.green,
                ),
                tappable: false,
              ),
              buildListItem("Permissions"),
              buildListItem("Download personal data"),
              buildListItem("Erase personal data"),
              buildListItem("Leave FitSync Health"),
            ]),
          ]),

          buildSectionTitle("Information"),
          buildCard([
            buildListGroup([
              buildListItem("About FitSync Health"),
              buildListItem("Help"),
            ]),
          ]),
        ],
      ),
    );
  }
}
