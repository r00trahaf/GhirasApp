import 'dart:convert';
import '../enum/Usertype.dart';
import '../enum/status.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.image,
    required this.name,
    required this.last,
    required this.uid,
    required this.email,
    required this.phone,
    required this.city,
    required this.password,
    required this.experience,
    required this.cv,
    required this.address,
    required this.certificate,
    required this.years,
    required this.id,
    required this.accountStatus,
    required this.section,
    required this.userType,
  });

  String image;
  String name;
  String last;
  String email;
  String years;
  String phone;
  String city;
  String password;
  String experience;
  String address;
  String uid;
  String id;
  String cv;
  String section;
  String certificate;
  Status accountStatus;
  Usertype userType;

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        image: json!["image"],
        name: json["name"],
        id: json["id"] ?? "24557",
        city: json["city"],
        address: json["address"],
        cv: json["cv"],
        password: json["password"],
        years: json["years"],
        experience: json["experience"],
        certificate: json["certificate"],
        section: json["section"] ?? '',
        phone: json["phone"],
        last: json["last"],
        email: json["email"],
        uid: json["uid"],
        accountStatus: Status.values[json["status"]],
        userType: Usertype.values[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'last': last,
        'uid': uid,
        'image': image,
        'email': email,
        'address': address,
        'city': city,
        'phone': phone,
        'password': password,
        'experience': experience,
        'certificate': certificate,
        'years': years,
        'section': section,
        'cv': cv,
        'status': accountStatus.index,
        'type': userType.index,
      };
}
