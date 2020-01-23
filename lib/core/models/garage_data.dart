// To parse this JSON data, do
//
//     final garageData = garageDataFromJson(jsonString);

import 'dart:convert';

GarageData garageDataFromJson(String str) =>
    GarageData.fromJson(json.decode(str));

String garageDataToJson(GarageData data) => json.encode(data.toJson());

class GarageData {
  bool error;
  String message;
  List<Place> places;

  GarageData({
    this.error,
    this.message,
    this.places,
  });

  factory GarageData.fromJson(Map<String, dynamic> json) => GarageData(
        error: json["error"],
        message: json["message"],
        places: List<Place>.from(json["Places"].map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "Places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}

class Place {
  String placeNumber;
  String status;
  String garageId;

  Place({
    this.placeNumber,
    this.status,
    this.garageId,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        placeNumber: json["place_number"],
        status: json["status"],
        garageId: json["garage_id"],
      );

  Map<String, dynamic> toJson() => {
        "place_number": placeNumber,
        "status": status,
        "garage_id": garageId,
      };
}
