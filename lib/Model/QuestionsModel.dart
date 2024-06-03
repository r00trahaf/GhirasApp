import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));


class QuestionsModel {
  QuestionsModel({
    required this.Questions,
    required this.id,
    required this.uid,
  });

  String Questions;
  String id;
  String uid;

  factory QuestionsModel.fromJson(Map<String, dynamic>? json) => QuestionsModel(
    Questions: json!["questions"],
    id: json["id"],
    uid: json["uid"],
  );
}