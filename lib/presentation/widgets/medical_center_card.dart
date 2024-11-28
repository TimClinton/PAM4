import 'package:flutter/material.dart';
import '../../domain/medical_center.dart';

class MedicalCenterCard extends StatelessWidget {
  final MedicalCenter center;

  const MedicalCenterCard({Key? key, required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Lățime consistentă
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12), // Padding ajustat
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Imagine cu colțuri rotunjite
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  center.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                center.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                center.address,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${center.rating} ★ (${center.reviews} Recenzii)',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${center.distance} / ${center.time}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
