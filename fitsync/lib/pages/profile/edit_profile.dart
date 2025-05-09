import 'package:fitsync/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EditProfileScreen());
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedGender = 'Male';

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // --- FRAME AVATAR ---
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile picture area
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: min(
                            MediaQuery.of(context).size.width * 0.35,
                            130,
                          ),
                          height: min(
                            MediaQuery.of(context).size.width * 0.35,
                            130,
                          ),

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.brown[200]!, Colors.brown[400]!],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                          width: min(
                            MediaQuery.of(context).size.width * 0.27,
                            100,
                          ),
                          height: min(
                            MediaQuery.of(context).size.width * 0.27,
                            100,
                          ),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              'Add a profile picture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Avatar List
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        // List asset image paths
                        final List<String> avatars = [
                          'assets/images/lau_nang.png',
                          'assets/images/brokoli.png',
                          'assets/images/cepol.png',
                          'assets/images/bondol.png',
                          'assets/images/add_avatar.png',
                        ];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: AssetImage(avatars[index]),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 20),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                          child: Text("Gallery"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                          child: Text("Camera"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: nicknameController,
                        decoration: InputDecoration(
                          labelText: "Nickname",
                          labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          hintText: "Enter your nickname",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- FORM PROFILE ---
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildGenderSelector(),
                    buildTextField("Height", heightController, Icons.height),
                    buildTextField(
                      "Weight",
                      weightController,
                      Icons.fitness_center,
                    ),
                    buildDatePickerField(
                      "Birth",
                      birthController,
                      Icons.cake,
                      context,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Text("Save", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePickerField(
    String label,
    TextEditingController controller,
    IconData icon,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextField(
        controller: controller,
        readOnly: true, // Menghindari input manual
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: Icon(Icons.calendar_today), // Ikon kalender
          border: UnderlineInputBorder(),
        ),
        onTap: () async {
          // Menampilkan DatePicker saat klik pada TextField
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), // Tanggal awal
            firstDate: DateTime(1900), // Tanggal awal yang bisa dipilih
            lastDate: DateTime.now(), // Tanggal akhir yang bisa dipilih
          );

          if (selectedDate != null) {
            // Jika tanggal dipilih, update controller dengan format yang diinginkan
            controller.text =
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
          }
        },
      ),
    );
  }

  Widget buildGenderSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Menjaga semua elemen sejajar vertikal
        children: [
          // Container dengan ukuran yang sama untuk menyesuaikan icon wc
          Container(
            width: 40, // Ukuran yang disesuaikan dengan icon lainnya
            height: 40, // Ukuran yang disesuaikan dengan icon lainnya
            alignment: Alignment.center,
            child: Icon(Icons.wc, color: Colors.grey[700]),
          ),
          SizedBox(width: 10), // Jarak antara icon dan text "Gender"
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.normal, // Supaya ringan seperti field lain
            ),
          ),
          SizedBox(width: 20), // Jarak agar antara text dan radio button cukup
          Flexible(
            fit:
                FlexFit
                    .tight, // Memastikan Row ini menyesuaikan ruang yang tersedia
            child: Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                      genderController.text = value;
                    });
                  },
                ),
                Text('Male'),
                // SizedBox(width: 20),
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                      genderController.text = value;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
