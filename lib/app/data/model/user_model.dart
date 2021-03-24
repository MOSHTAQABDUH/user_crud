import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:user_crud/app/global/constants.dart';

class User {
  int id;
  String email;
  String password;
  String name;
  DateTime birthDate;

  User({
    this.name,
    this.birthDate,
    this.email,
    this.password,
    this.id,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json[USER_EMAIL],
        password: json[USER_PASSWORD],
        name: json[USER_NAME],
        birthDate: DateTime.fromMillisecondsSinceEpoch(json[USER_BIRTHDATE]),
        id: json[USER_ID],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      USER_BIRTHDATE: this.birthDate.millisecondsSinceEpoch,
      USER_EMAIL: this.email,
      USER_NAME: this.name,
      USER_PASSWORD: md5.convert(utf8.encode(this.password)).toString(),
    };

    if (id != null) {
      map[USER_ID] = this.id;
    }

    return map;
  }
}
