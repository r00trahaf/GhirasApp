import 'dart:convert';

CaringModel caringModelFromJson(String str) => CaringModel.fromJson(json.decode(str));


class CaringModel {
  CaringModel({
    required this.plants,
    required this.id,
    required this.note,
    required this.uid,
    required this.number,
    required this.Duration,
  });

  String plants;
  String id;
  String note;
  String uid;
  String number;
  String Duration;

  factory CaringModel.fromJson(Map<String, dynamic>? json) => CaringModel(
    plants: json!["plants"],
    id: json["id"],
    note: json["note"],
    uid: json["uid"],
    number: json["number"],
    Duration: json["Duration"],
  );
}
