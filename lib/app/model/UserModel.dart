import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.nik,
    this.username,
    this.name,
    this.email,
    this.role,
    this.token,
  });

  String? nik;
  String? username;
  String? name;
  String? email;
  String? role;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nik: json["nik"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "username": username,
        "name": name,
        "email": email,
        "role": role,
        "token": token,
      };
}
