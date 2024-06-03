import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

AvailableModel availableModelFromJson(String str) => AvailableModel.fromJson(json.decode(str));

class AvailableModel {
  AvailableModel({
    required this.Date,
    required this.uid,
    required this.id,
  });

  DateTime Date;
  String uid;
  String id;

  factory AvailableModel.fromJson(Map<String, dynamic>? json) => AvailableModel(
        Date: json!["Date"] = ((json["Date"] as Timestamp).toDate()),
        uid: json["uid"],
        id: json["id"],
      );
}
