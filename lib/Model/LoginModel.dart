import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
    required this.mark,
  });

  String email;
  String password;
  bool mark;

  factory LoginModel.fromJson(Map<String, dynamic>? json) => LoginModel(
    password: json!["password"] ?? '',
    email: json["email"] ?? '',
    mark: json["mark"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'mark':mark,
  };
}
