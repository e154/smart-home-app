// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/common/common.dart';

Image imageFromJson(String str) => Image.fromJson(json.decode(str));

String imageToJson(Image data) => json.encode(data.toJson());

class Image {
  int id;
  String image;
  String mimeType;
  String name;
  int size;
  String thumb;
  String title;
  String url;
  DateTime createdAt;

  Image();

  factory Image.fromJson(Map<String, dynamic> json) {
    Image image = new Image();
    image.id = json["id"];
    image.image = json["image"];
    image.mimeType = json["mime_type"];
    image.name = json["name"];
    image.size = json["size"];
    image.thumb = json["thumb"];
    image.title = json["title"];
    image.url = json["url"];
    image.createdAt = DateTime.parse(ignoreSubMicro(json["created_at"]));

    return image;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "mime_type": mimeType,
        "name": name,
        "size": size,
        "thumb": thumb,
        "title": title,
        "url": url,
      };
}
