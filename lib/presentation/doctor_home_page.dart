import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../domain/doctor.dart';
import '../domain/medical_center.dart';
import 'widgets/category_icon.dart';
import 'widgets/doctor_list_item.dart';
import 'widgets/medical_center_card.dart';

class DoctorHomePage extends StatelessWidget {
  DoctorHomePage({Key? key}) : super(key: key);

  final DataService dataService = DataService();

  Future<List<Doctor>> loadDoctors() => dataService.loadDoctors();

  Future<List<MedicalCenter>> loadMedicalCenters() => dataService.loadMedicalCenters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Găsește-ți Doctorul', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 16),
        ],
        leading: const Icon(Icons.location_on, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Locație
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Seattle, SUA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              const SizedBox(height: 16),

              // Bara de căutare
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Caută doctor...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Secțiunea specialiști
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green[100],
                ),
                child: Row(
                  children: <Widget>[
                    // Prevenirea depășirii spațiului
                    Expanded(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cauți doctori specialiști?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Programează o întâlnire cu cei mai buni doctori ai noștri.'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Imagine ajustată
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1600585154340-be6161a56a0c'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Categorii
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorii',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Vezi tot'),
                ],
              ),
              const SizedBox(height: 16),

              // Grid pentru Categorii
              GridView.count(
                shrinkWrap: true, // Important pentru a evita eroarea de depășire
                physics: const NeverScrollableScrollPhysics(), // Previne scroll-ul intern
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  CategoryIcon(label: 'Stomatologie', icon: Icons.medical_services),
                  CategoryIcon(label: 'Cardiologie', icon: Icons.favorite),
                  CategoryIcon(label: 'Pneumologie', icon: Icons.air),
                  CategoryIcon(label: 'General', icon: Icons.person),
                  CategoryIcon(label: 'Neurologie', icon: Icons.psychology),
                  CategoryIcon(label: 'Gastro', icon: Icons.local_hospital),
                  CategoryIcon(label: 'Laborator', icon: Icons.biotech),
                  CategoryIcon(label: 'Vaccinare', icon: Icons.vaccines),
                ],
              ),
              const SizedBox(height: 16),

              // Centre medicale apropiate
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Centre Medicale Apropiate',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Vezi tot'),
                ],
              ),
              const SizedBox(height: 16),

              // ListView orizontal pentru centre medicale
              FutureBuilder<List<MedicalCenter>>(
                future: loadMedicalCenters(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Eroare la încărcarea centrelor medicale.');
                  } else {
                    final medicalCenters = snapshot.data!;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medicalCenters.length,
                        itemBuilder: (context, index) {
                          final center = medicalCenters[index];
                          return MedicalCenterCard(center: center);
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),

              // Secțiunea Top Doctori
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Doctori',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Vezi tot'),
                ],
              ),
              const SizedBox(height: 16),

              // Lista Doctorilor
              FutureBuilder<List<Doctor>>(
                future: loadDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Eroare la încărcarea doctorilor.');
                  } else {
                    final doctors = snapshot.data!;
                    return Column(
                      children: doctors.map((doctor) {
                        return DoctorListItem(doctor: doctor);
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
