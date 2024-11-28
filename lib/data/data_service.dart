import 'dart:convert';
import 'package:flutter/services.dart';
import '../domain/doctor.dart';
import '../domain/medical_center.dart';

class DataService {
  Future<List<Doctor>> loadDoctors() async {
    String jsonString = await rootBundle.loadString('assets/doctors.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => Doctor(
      imageUrl: json['imageUrl'],
      name: json['name'],
      specialty: json['specialty'],
      location: json['location'],
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'],
    )).toList();
  }

  Future<List<MedicalCenter>> loadMedicalCenters() async {
    String jsonString = await rootBundle.loadString('assets/medical_centers.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => MedicalCenter(
      name: json['name'],
      address: json['address'],
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'],
      distance: json['distance'],
      time: json['time'],
      imageUrl: json['imageUrl'],
    )).toList();
  }
}
