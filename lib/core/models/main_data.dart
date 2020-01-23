// To parse this JSON data, do
//
//     final mainData = mainDataFromJson(jsonString);

import 'dart:convert';

//String mainDataToJson(List<MainData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainData {
  String the0;
  String the1;
  String id;
  String name;

  MainData({
    this.the0,
    this.the1,
    this.id,
    this.name,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        the0: json["0"],
        the1: json["1"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "id": id,
        "name": name,
      };
}
