import 'dart:convert';

HeatModel heatModelFromJson(String str) => HeatModel.fromJson(json.decode(str));

class HeatModel {
  HeatModel({
    required this.heat,
    required this.id,
  });

  String heat;
  String id;

  factory HeatModel.fromJson(Map<String, dynamic>? json) => HeatModel(
    heat: json!["Heat"],
    id: json["id"],
  );
}
