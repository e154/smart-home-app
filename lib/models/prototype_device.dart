// To parse this JSON data, do
//
//     final prototypeDevice = prototypeDeviceFromJson(jsonString);

import 'dart:convert';
import 'package:smart_home_app/models/prototype.dart';

PrototypeDevice prototypeDeviceFromJson(String str) =>
    PrototypeDevice.fromJson(json.decode(str));

String prototypeDeviceToJson(PrototypeDevice data) =>
    json.encode(data.toJson());

class PrototypeDevice extends Prototype {
  int id;

  PrototypeDevice({
    this.id,
  });

  factory PrototypeDevice.fromJson(Map<String, dynamic> json) =>
      PrototypeDevice(
        id: json["id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
