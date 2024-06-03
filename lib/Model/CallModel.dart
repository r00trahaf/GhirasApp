
import 'dart:convert';

SessionCallModel randomModelFromJson(String str) => SessionCallModel.fromJson(json.decode(str));


class SessionCallModel {
  SessionCallModel({
    required this.Status,
    required this.offer,
    required this.uidUser,
    required this.id,
    required this.uidSpecialist,
    required this.answer,
  });


  bool Status;
  String uidSpecialist;
  String uidUser;
  String id;
  Map<String, dynamic> offer;
  Map<String, dynamic> answer;


  factory SessionCallModel.fromJson(Map<String, dynamic>? json) => SessionCallModel(
    Status: json!["Status"],
    uidSpecialist: json["uidSpecialist"],
    uidUser: json["uidUser"] ?? '',
    id: json["id"] ?? '',
    offer: Map.from(json["offer"]),
    answer: Map.from(json["answer"] ?? {}),
  );
}