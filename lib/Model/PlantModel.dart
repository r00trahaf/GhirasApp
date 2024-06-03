import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

PlantModel availableModelFromJson(String str) => PlantModel.fromJson(json.decode(str));

class PlantModel {
  PlantModel({
    required this.id,
    required this.logo,
    required this.plant,
    required this.note,
    required this.toxic,
    required this.heat,
    required this.uid,
  });

  String heat;
  String logo;
  String note;
  String plant;
  String id;
  String uid;
  bool toxic;

  factory PlantModel.fromJson(Map<String, dynamic>? json) => PlantModel(
    id: json!["id"],
    logo: json["logo"],
    plant: json["plant"],
    note: json["note"],
    heat: json["Heat"],
    uid: json["uid"],
    toxic: json["Toxic"],
  );
}