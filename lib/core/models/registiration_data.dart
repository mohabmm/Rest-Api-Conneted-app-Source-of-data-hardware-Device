// To parse this JSON data, do
//
//     final registiration = registirationFromJson(jsonString);

import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  bool success;
  String message;
  UserSignUpData data;

  Registration({
    this.success,
    this.message,
    this.data,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        data: UserSignUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserSignUpData {
  String phone;
  String password;
  String email;
  String car_model;

  UserSignUpData({
    this.phone,
    this.password,
    this.email,
    this.car_model
  });

  factory UserSignUpData.fromJson(Map<String, dynamic> json) => UserSignUpData(
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
    car_model: json["car_model"],

  );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["phone"] = phone;
    map["email"] = email;
    map["password"] = password;
    map["car_model"] = car_model;

    return map;
  }

  Map<String, dynamic> toJson() => {
        "device_id": phone,
        "email": email,
        "password": password,
        "car_model": car_model,

  };
}

class Response {
  int id;
  String name;
  String token;
  String email;
  String createdAt;

  Response({
    this.id,
    this.name,
    this.token,
    this.email,
    this.createdAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        token: json["token"],
        email: json["email"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "token": token,
        "email": email,
        "created_at": createdAt,
      };
}
