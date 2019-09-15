// To parse this JSON data, do
//
//     final serverImage = serverImageFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

ServerImage serverImageFromJson(String str) =>
    ServerImage.fromJson(json.decode(str));

String serverImageToJson(ServerImage data) => json.encode(data.toJson());

class ServerImage {
  int id;
  String url;

  ServerImage(
    this.id,
    this.url,
  );

  factory ServerImage.fromJson(Map<String, dynamic> json) {
    return ServerImage(
      json["id"] as int,
      json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
