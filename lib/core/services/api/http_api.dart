import 'dart:async';
import 'dart:convert';
import 'package:ahmedapp/core/models/area_data.dart';
import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/core/models/garage_data.dart';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:ahmedapp/core/models/reserve_spot.dart';
import 'package:ahmedapp/core/models/user.dart';
import 'package:ahmedapp/ui/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ahmedapp/core/models/login.dart';
import 'package:ahmedapp/core/models/registiration_data.dart';
import 'package:ahmedapp/core/services/api/api.dart';
import 'package:ahmedapp/ui/utilities/show_snack_bar.dart';
import 'package:rxdart/rxdart.dart';

class HttpApi implements Api {
  var client = new http.Client();
  static const endpointLogin = 'http://al-ghalab.com/EX/Grad/ABI/login.php';
  static const endpointSignUp = 'http://al-ghalab.com/EX/Grad/ABI/reg.php';
  static const getMainDataEndPoint =
      'http://al-ghalab.com/EX/Grad/ABI/area.php';

  static const getAreaDataEndPoint =
      'http://al-ghalab.com/EX/Grad/ABI/garage.php';

  static const emptyGarages =
      'http://al-ghalab.com/EX/Grad/ABI/places.php?place=';

  static const reserveGarageEndPoint =
      'http://al-ghalab.com/EX/Grad/ABI/reserved.php';
  static StreamController<User> userController = new BehaviorSubject();
//  Stream<User> get userStream => userController.stream;

  @override
  Future<UserSignUpData> signUp(Map body, BuildContext context) async {
    return http
        .post(endpointSignUp, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

      if (statusCode == 200) {
        showSnackBar('User Registered Successfully');
        Navigator.pushReplacementNamed(context, 'signinformem');
        return;
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error found");
      }
      throw new Exception("Error while fetching data");
    });
  }

  @override
  Future<User> logIn(Map body, BuildContext context) async {
    return http
        .post(endpointLogin, body: body)
        .then((http.Response response) async {
      User userFromJson(String str) => User.fromJson(json.decode(str));

      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

      bool error = responses["error"];
      String message = responses['message'];
      if (error == true) {
        showSnackBar(message);
      }

      if (statusCode == 200 && error == false) {
        showSnackBar('User Registered Successfully');
        //Todo navigate her
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeView()),
            (Route<dynamic> route) => false);

        print("the current user id  dirong parsing is " +
            userFromJson(response.body).id);
        userController.add(userFromJson(response.body));
        return userFromJson(response.body);
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        if (error == true) {
          showSnackBar(message);
        } else
          print("error found");
      }

      return userFromJson(response.body) ?? "null";
    });
  }

  @override
  Future<List<MainData>> getMainData() async {
    final response = await http.post(getMainDataEndPoint);
    print("the main data response body is " + response.body);

    List<MainData> mainDataFromJson(String str) =>
        List<MainData>.from(json.decode(str).map((x) => MainData.fromJson(x)));
    List data = mainDataFromJson(response.body);

    return data;
  }

  @override
  Future<List<AreaData>> getAreaData(Map body) {
    return http
        .post(getAreaDataEndPoint, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      List<AreaData> mainDataFromJson(String str) => List<AreaData>.from(
          json.decode(str).map((x) => AreaData.fromJson(x)));
      List data = mainDataFromJson(response.body);
      return data;
    });
  }

  @override
  Future<GarageData> getGarageData(String body) async {
    final response = await http.get(emptyGarages + body);
    GarageData garageDataFromJson(String str) =>
        GarageData.fromJson(json.decode(str));
    return garageDataFromJson(response.body);
  }

  @override
  Future<ReserveSpot> reserveSpot(Map body) {
    http
        .post(reserveGarageEndPoint, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print(
          "the status code of reserving the spot is " + statusCode.toString());
      print('Response body of reserve spot is  : ${response.body}');
      return;
    });
  }
}
