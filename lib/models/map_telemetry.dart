// To parse this JSON data, do
//
//     final mapTelemetry = mapTelemetryFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/models/response_payload.dart';

MapTelemetry mapTelemetryFromJson(String str) =>
    MapTelemetry.fromJson(json.decode(str));

class MapTelemetry extends ResponsePayload {
  MapTelemetryDevice device;

  MapTelemetry({
    this.device,
  });

  factory MapTelemetry.fromJson(Map<String, dynamic> json) {
    return MapTelemetry(
      device: (json['device'] != null)? MapTelemetryDevice.fromJson(json['device']): null,
    );
  }

  Map<String, dynamic> toJson() => {
    "device": device.toJson(),
  };
}
