// To parse this JSON data, do
//
//     final userHistory = userHistoryFromJson(jsonString);

import 'dart:convert';

UserHistory userHistoryFromJson(String str) =>
    UserHistory.fromJson(json.decode(str));

String userHistoryToJson(UserHistory data) => json.encode(data.toJson());

class UserHistory {
  String ip;
  DateTime time;

  UserHistory({
    this.ip,
    this.time,
  });

  factory UserHistory.fromJson(Map<String, dynamic> json) => new UserHistory(
        ip: json["ip"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "time": time,
      };
}
