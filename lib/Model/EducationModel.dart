

class EducationModel {
  EducationModel({
    required this.id,
    required this.Title,
    required this.logo,
  });

  String id;
  String Title;
  String logo;

  factory EducationModel.fromJson(Map<String, dynamic>? json) => EducationModel(
    id: json!["id"],
    Title: json["Title"],
    logo: json["logo"],
  );
}


class EducationTap {
  EducationTap({
    required this.id,
    required this.uid,
    required this.Title,
    required this.logo,
  });

  String id;
  String uid;
  String Title;
  String logo;

  factory EducationTap.fromJson(Map<String, dynamic>? json) => EducationTap(
    id: json!["id"],
    uid: json!["uid"],
    Title: json["Title"],
    logo: json["logo"],
  );
}


class EducationDrs {
  EducationDrs({
    required this.id,
    required this.uid,
    required this.Title,
    required this.logo,
  });

  String id;
  String uid;
  String Title;
  List<String> logo;

  factory EducationDrs.fromJson(Map<String, dynamic>? json) => EducationDrs(
    id: json!["id"],
    uid: json!["uid"],
    Title: json["Title"],
    logo: json["logo"].toString().split(", "),
  );
}