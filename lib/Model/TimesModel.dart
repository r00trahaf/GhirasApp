import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

TimesModel timesModelFromJson(String str) => TimesModel.fromJson(json.decode(str));

class TimesModel {
  TimesModel({
    required this.date,
    required this.uid,
    required this.id,
    required this.note,
    required this.plant,
  });

  DateTime date;
  String uid;
  String id;
  String note;
  String plant;

  factory TimesModel.fromJson(Map<String, dynamic>? json) => TimesModel(
        date: json!["Date"] = ((json["Date"] as Timestamp).toDate()),
        uid: json["uid"],
        id: json["id"],
        note: json["note"],
        plant: json["plant"],
      );
}
