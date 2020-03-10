// To parse this JSON data, do
//
//     final device = mapElementFromJson(jsonString);

import 'dart:convert';

import 'package:smart_home_app/models/graph_settings.dart';
import 'package:smart_home_app/models/map_zone.dart';
import 'package:smart_home_app/models/prototype.dart';
import 'package:smart_home_app/models/prototype_device.dart';

MapElement mapElementFromJson(String str) => MapElement.fromJson(json.decode(str));

String mapElementToJson(MapElement data) => json.encode(data.toJson());

class MapElement {
  int id, prototypeId, mapId, layerId, weight;
  String name, description, prototypeType, status;
  Prototype prototype;
  GraphSettings graphSettings;
  MapZone zone;

  MapElement({
    this.id,
    this.name,
    this.description,
    this.prototypeId,
    this.prototypeType,
    this.prototype,
    this.mapId,
    this.layerId,
    this.graphSettings,
    this.status,
    this.weight,
    this.zone,
  });

  factory MapElement.fromJson(Map<String, dynamic> json) {
    final prototypeType = json["prototype_type"];
    Prototype prototype;
    switch (prototypeType) {
      case 'device':
        prototype = PrototypeDevice.fromJson(json["prototype"]);
        break;
      default:
        print("unknown type: $prototypeType");
    }
    return MapElement(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
      prototypeId: json["prototype_id"] as int,
      prototypeType: prototypeType,
      prototype: prototype,
      mapId: json["map_id"] as int,
      layerId: json["layer_id"] as int,
      graphSettings: GraphSettings.fromJson(json["graph_settings"]),
      status: json["status"],
      weight: json["weight"] as int,
      zone: json["zone"] != null ? MapZone.fromJson(json["zone"]) : null
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "prototype_id": prototypeId,
        "prototype_type": prototypeType,
        "prototype": prototype,
        "map_id": mapId,
        "layer_id": layerId,
        "graph_settings": graphSettings,
        "status": status,
        "weight": weight,
        "zone": zone,
      };
}
