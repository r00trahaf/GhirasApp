import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../enum/report.dart';
import '../enum/status.dart';

ReportsModel reportsModelFromJson(String str) => ReportsModel.fromJson(json.decode(str));

class ReportsModel {
  ReportsModel({
    required this.id,
    required this.createdDate,
    required this.title,
    required this.note,
    required this.uidUser,
    required this.nameUser,
    required this.phone,
    required this.idUser,
    required this.uidSpecialist,
    required this.idSpecialist,
    required this.place,
    required this.report,
    required this.status,
    required this.rejected,
  });

  String? id;
  String? rejected;
  DateTime createdDate;
  String? title;
  String? note;
  String? phone;
  String? uidUser;
  String? nameUser;
  String? idUser;
  String? uidSpecialist;
  String? idSpecialist;
  String? place;
  Report report;
  Status status;

  factory ReportsModel.fromJson(Map<String, dynamic>? json) => ReportsModel(
    createdDate: json!["CreatedDate"] = ((json["CreatedDate"] as Timestamp).toDate()),
    report: Report.values[json["Report"]],
    status: Status.values[json["status"]],
    rejected: json["Rejected"],
    phone: json["phone"],
    place: json["place"],
    id: json["id"],
    title: json["title"],
    note: json["note"],
    uidUser: json["uidUser"],
    nameUser: json["nameUser"],
    idUser: json["idUser"],
    uidSpecialist: json["uidSpecialist"],
    idSpecialist: json["idSpecialist"],
  );
}
