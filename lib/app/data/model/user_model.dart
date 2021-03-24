import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:user_crud/app/global/constants.dart';

class UserModel {
  String id;
  String email;
  String password;
  String name;
  DateTime birthDate;

  UserModel({
    this.name,
    this.birthDate,
    this.email,
    this.password,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json[USER_EMAIL],
        password: json[USER_PASSWORD],
        name: json[USER_NAME],
        birthDate: DateTime.tryParse(json[USER_BIRTHDATE]),
        id: json[USER_ID],
      );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      USER_BIRTHDATE: this.birthDate.toIso8601String(),
      USER_EMAIL: this.email,
      USER_NAME: this.name,
      USER_PASSWORD: md5.convert(utf8.encode(this.password)).toString(),
      USER_ID: this.id,
    };
    return map;
  }

  Map<String, dynamic> toJsonWithoutId() {
    var map = <String, dynamic>{
      USER_BIRTHDATE: this.birthDate.toIso8601String(),
      USER_EMAIL: this.email,
      USER_NAME: this.name,
      USER_PASSWORD: md5.convert(utf8.encode(this.password)).toString(),
    };
    return map;
  }

  static List<UserModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }
}
