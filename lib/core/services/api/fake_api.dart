import 'package:ahmedapp/core/models/area_data.dart';
import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/core/models/garage_data.dart';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:ahmedapp/core/models/reserve_spot.dart';
import 'package:ahmedapp/core/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahmedapp/core/models/login.dart';
import 'package:ahmedapp/core/models/registiration_data.dart';
import 'package:ahmedapp/core/services/api/api.dart';

class FakeApi implements Api {
  UserSignUpData data = UserSignUpData(
    email: 'mohab_31_8@hotmail.com',
    phone: 'mohab',
    password: '123456',
  );

  @override
  Future<UserSignUpData> signUp(Map body, BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    if (data.phone == "mohab") {
      print("great");
    } else if (data.email == "mohab.magdy1@msa.edu.eg") {
      print("fake email");
    } else {
      print("signed up succefully");
    }
    return UserSignUpData(
      phone: "",
      email: '',
      password: '',
    );
  }

  @override
  Future<User> logIn(Map body, BuildContext context) {
    // TODO: implement logIn
    return null;
  }

  @override
  Future<List<MainData>> getMainData() {
    // TODO: implement getMainData
    return null;
  }

  @override
  Future<List<AreaData>> getAreaData(Map id) {
    // TODO: implement getAreaData
    return null;
  }

  @override
  Future<GarageData> getGarageData(String body) {
    // TODO: implement reserveGarage
    return null;
  }

  @override
  Future<ReserveSpot> reserveSpot(Map body) {
    // TODO: implement reserveSpot
    return null;
  }
}
