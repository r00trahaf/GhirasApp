import 'dart:convert';

import '../enum/Supporttype.dart';

SupportModel supportModelFromJson(String str) =>
    SupportModel.fromJson(json.decode(str));

class SupportModel {
  SupportModel({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  String? title;
  String? subtitle;
  SupportType type;

  factory SupportModel.fromJson(Map<String, dynamic>? json) => SupportModel(
        title: json!["title"],
        subtitle: json["subtitle"],
        type: SupportType.values[json["type"]],
      );
}
