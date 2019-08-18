// To parse this JSON data, do
//
//     final credentials = credentialsFromJson(jsonString);

import 'dart:convert';

Credentials credentialsFromJson(String str) =>
    Credentials.fromJson(json.decode(str));

String credentialsToJson(Credentials data) => json.encode(data.toJson());

class Credentials {
  String userLogin = "";
  String userPassword = "";

  Credentials();

  bool get isValid => userLogin != "" && userPassword != "";

  factory Credentials.fromJson(Map<String, dynamic> json) {
    Credentials credentials = new Credentials();
    credentials.userLogin = json["user_login"];
    credentials.userPassword = json["user_password"];

    return credentials;
  }

  Map<String, dynamic> toJson() => {
        "user_login": userLogin,
        "user_password": userPassword,
      };

  bool equal(Credentials s) {
    return s.userPassword == userPassword && s.userLogin == userLogin;
  }
}
