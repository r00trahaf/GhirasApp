import 'dart:convert';

ReviewsModel supportModelFromJson(String str) => ReviewsModel.fromJson(json.decode(str));

class ReviewsModel {
  ReviewsModel({
    required this.logo,
    required this.name,
    required this.note,
    required this.review,
    required this.uid,
    required this.id,
    required this.uidSpecialist,
  });

  String logo;
  String name;
  String note;
  String uid;
  String id;
  String uidSpecialist;
  double review;

  factory ReviewsModel.fromJson(Map<String, dynamic>? json) => ReviewsModel(
    logo: json!["logo"],
    name: json["name"],
    note: json["note"],
    uid: json["uid"],
    id: json["id"],
    uidSpecialist: json["uidSpecialist"],
    review: json["review"],
  );
}
