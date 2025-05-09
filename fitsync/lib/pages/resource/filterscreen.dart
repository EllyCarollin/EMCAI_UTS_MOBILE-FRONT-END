import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // State untuk chip pilihan
  List<String> selectedCategories = [];
  List<String> selectedDifficulties = [];
  RangeValues selectedDuration = RangeValues(0, 50);
  List<String> selectedBodyParts = [];
  List<String> selectedEquipments = [];

  List<String> categories = [
    'Penurunan berat badan',
    'Membangun otot',
    'Latihan ketahanan',
    'Latihan keseimbangan',
  ];

  List<String> difficulties = ['Pemula', 'Sedang', 'Ahli'];

  List<String> bodyParts = [
    'Tubuh bagian atas',
    'Tubuh bagian bawah',
    'Seluruh tubuh',
    'Otot Inti',
  ];

  List<String> equipments = ['Wajib', 'Tdk diperlukan'];

  void resetFilters() {
    setState(() {
      selectedCategories.clear();
      selectedDifficulties.clear();
      selectedDuration = RangeValues(0, 50);
      selectedBodyParts.clear();
      selectedEquipments.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background to white
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Filter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildSectionTitle('Kategori program'),
            buildChips(categories, selectedCategories),

            buildSectionTitle('Kesulitan'),
            buildChips(difficulties, selectedDifficulties),

            buildSectionTitle('Durasi olahraga'),
            RangeSlider(
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              values: selectedDuration,
              min: 0,
              max: 50,
              divisions: 5,
              labels: RangeLabels(
                '${selectedDuration.start.round()} mnt',
                '${selectedDuration.end >= 50 ? '50+' : selectedDuration.end.round().toString()} mnt',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectedDuration = values;
                });
              },
            ),
            SizedBox(height: 16),

            buildSectionTitle('Anggota tubuh'),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[800],
              child: Center(
                child: Text(
                  'Gambar Tubuh di sini',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            buildChips(bodyParts, selectedBodyParts),

            buildSectionTitle('Peralatan'),
            buildChips(equipments, selectedEquipments),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color:
            Colors.white, // Set bottom navigation bar background color to white
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement Apply Filter
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: Text(
                'Selesai',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildChips(List<String> options, List<String> selectedList) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          options.map((option) {
            final isSelected = selectedList.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: Colors.green, // Green when selected
              backgroundColor: Colors.grey[300], // Light grey when not selected
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ), // White label text when selected
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedList.add(option);
                  } else {
                    selectedList.remove(option);
                  }
                });
              },
            );
          }).toList(),
    );
  }
}
