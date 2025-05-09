import 'package:flutter/material.dart';
import 'package:fitsync/pages/profile/profile.dart';
import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: ResourcesScreen(),
    );
  }
}

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final List<Map<String, String>> allResources = [
    // ... (data resource kamu yang panjang itu tetap sama)
    {
      'title': 'Zumba',
      'image': 'assets/zumba.jpeg',
      'duration': '30',
      'description':
          'A fun workout to improve your flexibility and cardiovascular health.',
      'difficulty': 'Pemula',
      'programmeCategory': 'Penurunan berat badan',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Squad Jump',
      'image': 'assets/Jump-Squats.jpg',
      'duration': '15',
      'description': 'Great for toning your legs and improving endurance.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Membangun otot',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Tubuh bagian bawah',
    },
    {
      'title': 'Stretch',
      'image': 'assets/stretch.jpeg',
      'duration': '20',
      'description': 'Focus on flexibility and relaxation.',
      'difficulty': 'Pemula',
      'programmeCategory': 'Latihan keseimbangan',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Cardio & Abs',
      'image': 'assets/cardioabs.jpeg',
      'duration': '25',
      'description': 'High-intensity cardio combined with abdominal exercises.',
      'difficulty': 'Ahli',
      'programmeCategory': 'Penurunan berat badan',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Otot Inti',
    },
    {
      'title': 'Squad Challenge',
      'image': 'assets/squad_challenge.webp',
      'duration': '40',
      'description': 'Challenge yourself with this full-body workout.',
      'difficulty': 'Ahli',
      'programmeCategory': 'Membangun otot',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Yoga',
      'image': 'assets/yoga.jpeg',
      'duration': '30',
      'description':
          'A calming workout that promotes flexibility and relaxation.',
      'difficulty': 'Pemula',
      'programmeCategory': 'Latihan keseimbangan',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Pilates',
      'image': 'assets/pilates.jpeg',
      'duration': '25',
      'description': 'Focus on core strength and overall body toning.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Latihan ketahanan',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Otot Inti',
    },
    {
      'title': 'HIIT',
      'image': 'assets/hiit.jpeg',
      'duration': '20',
      'description': 'High-intensity interval training for full-body fitness.',
      'difficulty': 'Ahli',
      'programmeCategory': 'Penurunan berat badan',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Jump Rope',
      'image': 'assets/jump_rope.jpeg',
      'duration': '15',
      'description': 'Great for cardiovascular health and endurance.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Latihan ketahanan',
      'equipment': 'Wajib',
      'bodyPart': 'Tubuh bagian bawah',
    },
    {
      'title': 'Cycling',
      'image': 'assets/cycling.jpeg',
      'duration': '35',
      'description':
          'Cardio workout focused on improving stamina and leg strength.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Latihan ketahanan',
      'equipment': 'Wajib',
      'bodyPart': 'Tubuh bagian bawah',
    },
    {
      'title': 'Weight Lifting',
      'image': 'assets/weight_lifting.jpeg',
      'duration': '45',
      'description': 'Build strength with weight training exercises.',
      'difficulty': 'Ahli',
      'programmeCategory': 'Membangun otot',
      'equipment': 'Wajib',
      'bodyPart': 'Tubuh bagian atas',
    },
    {
      'title': 'CrossFit',
      'image': 'assets/crossfit.jpeg',
      'duration': '40',
      'description': 'Intense workout combining strength and conditioning.',
      'difficulty': 'Ahli',
      'programmeCategory': 'Membangun otot',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Kickboxing',
      'image': 'assets/kickboxing.jpeg',
      'duration': '30',
      'description':
          'High-intensity training that improves strength and agility.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Latihan ketahanan',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Calisthenics',
      'image': 'assets/calisthenics.jpg',
      'duration': '20',
      'description': 'Strength training using your body weight.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Membangun otot',
      'equipment': 'Tdk diperlukan',
      'bodyPart': 'Seluruh tubuh',
    },
    {
      'title': 'Swimming',
      'image': 'assets/swimming.jpg',
      'duration': '60',
      'description': 'A comprehensive workout for preparing for a triathlon.',
      'difficulty': 'Sedang',
      'programmeCategory': 'Latihan ketahanan',
      'equipment': 'Wajib',
      'bodyPart': 'Seluruh tubuh',
    },
  ];

  List<Map<String, String>>? filteredResources; // null = tampil semua

  void applyFilters(Map<String, dynamic> filters) {
    setState(() {
      filteredResources =
          allResources.where((resource) {
            bool matchesCategory =
                filters['categories'].isEmpty ||
                filters['categories'].contains(resource['programmeCategory']);
            bool matchesDifficulty =
                filters['difficulties'].isEmpty ||
                filters['difficulties'].contains(resource['difficulty']);
            bool matchesDuration =
                (resource['duration'] != null &&
                    int.tryParse(resource['duration']!) != null &&
                    int.tryParse(resource['duration']!)! >=
                        filters['duration'].start &&
                    int.tryParse(resource['duration']!)! <=
                        filters['duration'].end);
            bool matchesBodyPart =
                filters['bodyParts'].isEmpty ||
                filters['bodyParts'].contains(resource['bodyPart']);
            bool matchesEquipment =
                filters['equipments'].isEmpty ||
                filters['equipments'].contains(resource['equipment']);

            return matchesCategory &&
                matchesDifficulty &&
                matchesDuration &&
                matchesBodyPart &&
                matchesEquipment;
          }).toList();

      if (filters['categories'].isEmpty &&
          filters['difficulties'].isEmpty &&
          filters['bodyParts'].isEmpty &&
          filters['equipments'].isEmpty &&
          (filters['duration'].start == 0 && filters['duration'].end == 50)) {
        filteredResources = null; // Balik ke semua kalau filter kosong
      }
    });
  }

  Future<void> openFilters() async {
    final filters = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FiltersScreen()),
    );

    if (filters != null) {
      applyFilters(filters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentResources = filteredResources ?? allResources;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg', // Path ke file SVG kamu
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        HomePage(), // Ganti dengan nama halaman utama kamu
              ),
              (route) => false,
            );
          },
        ),
        title: Text('Resources', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.tune, color: Colors.black),
            onPressed: openFilters,
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child:
            filteredResources == null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkoutSection(
                      title: 'Popular Workouts',
                      resources: allResources.sublist(0, 5),
                    ),
                    WorkoutSection(
                      title: 'More Workouts',
                      resources: allResources.sublist(5, 10),
                    ),
                    WorkoutSection(
                      title: 'Strength Workouts',
                      resources: allResources.sublist(10),
                    ),
                  ],
                )
                : WorkoutSection(
                  title: 'Filtered Workouts',
                  resources: currentResources,
                ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Tetap 0 karena ini halaman home
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ), // Ganti HomePage() sesuai nama halaman home kamu
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FitnessApp()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/fitness_active.png', height: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile.png', height: 40),
            label: '',
          ),
        ],
      ),
    );
  }
}

class WorkoutSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> resources;

  WorkoutSection({required this.title, required this.resources});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      resources
                          .map(
                            (resource) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: ResourceCard(resource),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final Map<String, String> resource;

  ResourceCard(this.resource);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => WorkoutDetailScreen(
                  title: resource['title']!,
                  image: resource['image']!,
                  duration: resource['duration']!,
                  description: resource['description']!,
                  caloriesBurned: '0',
                  equipment: resource['equipment']!,
                  difficulty: resource['difficulty']!,
                  programmeCategory: resource['programmeCategory']!,
                ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 100,
                width: double.infinity,
                child: Image.asset(resource['image']!, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource['title']!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap to see more details!',
                    style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String duration;
  final String description;
  final String caloriesBurned;
  final String equipment;
  final String difficulty;
  final String programmeCategory;

  WorkoutDetailScreen({
    required this.title,
    required this.image,
    required this.duration,
    required this.description,
    required this.caloriesBurned,
    required this.equipment,
    required this.difficulty,
    required this.programmeCategory,
  });

  @override
  Widget build(BuildContext context) {
    final bool needsEquipment =
        equipment.toLowerCase() != 'tdk diperlukan' &&
        equipment.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg', // Path ke file SVG kamu
            height: 20, // Ukuran gambar SVG
            width: 20, // Ukuran gambar SVG
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 48,
                      height: 220,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 95,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Playing $title workout video...'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Programme Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(difficulty, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text(
                            'Difficulty',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('$duration mnt', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text(
                            'Duration',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Equipment', style: TextStyle(fontSize: 16)),
                      Spacer(),
                      if (needsEquipment) ...[
                        Text(equipment, style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Icon(Icons.error_outline, size: 20, color: Colors.red),
                      ] else ...[
                        Text('None', style: TextStyle(fontSize: 16)),
                      ],
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Programme category:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Text(programmeCategory, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Center(
            child: SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Start workout pressed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Filter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg', // Path ke file SVG kamu
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
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

            const SizedBox(height: 12),
            buildChips(bodyParts, selectedBodyParts),

            buildSectionTitle('Peralatan'),
            buildChips(equipments, selectedEquipments),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
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
                // Return the selected filters
                final filters = {
                  'categories': selectedCategories,
                  'difficulties': selectedDifficulties,
                  'duration': selectedDuration,
                  'bodyParts': selectedBodyParts,
                  'equipments': selectedEquipments,
                };
                Navigator.pop(context, filters);
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
              selectedColor: Colors.green,
              backgroundColor: Colors.grey[300],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
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
