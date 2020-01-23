// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

String userToJson(User data) => json.encode(data.toJson());

class User {
  bool error;
  String id;
  String email;
  dynamic phone;

  User({
    this.error,
    this.id,
    this.email,
    this.phone,
  });
//  User.initial()
//      : id = "0",
//        error = false,
//        email = '',
//        phone = '';

  factory User.fromJson(Map<String, dynamic> json) => User(
        error: json["error"],
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "email": email,
        "phone": phone,
      };
}
