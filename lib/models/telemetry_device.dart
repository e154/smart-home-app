// To parse this JSON data, do
//
//     final telemetryDevice = telemetryDeviceFromJson(jsonString);

import 'dart:convert';

TelemetryDevice telemetryDeviceFromJson(String str) =>
    TelemetryDevice.fromJson(json.decode(str));

String telemetryDeviceToJson(TelemetryDevice data) =>
    json.encode(data.toJson());

class TelemetryDevice {
  int id, deviceId;
  String description, systemName;

  TelemetryDevice({
    this.id,
    this.description,
    this.systemName,
    this.deviceId,
  });

  factory TelemetryDevice.fromJson(Map<String, dynamic> json) =>
      TelemetryDevice(
        id: json["id"] as int,
        description: json["description"],
        systemName: json["system_name"],
        deviceId: json["device_id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "system_name": systemName,
        "device_id": deviceId,
      };
}
