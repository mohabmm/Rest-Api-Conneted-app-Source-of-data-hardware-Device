import 'package:ahmedapp/core/models/area_data.dart';
import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/core/models/garage_data.dart';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:ahmedapp/core/models/reserve_spot.dart';
import 'package:ahmedapp/core/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahmedapp/core/models/login.dart';
import 'package:ahmedapp/core/models/registiration_data.dart';

abstract class Api {
  Future<UserSignUpData> signUp(Map body, BuildContext context);
  Future<User> logIn(Map body, BuildContext context);
  Future<List<MainData>> getMainData();
  Future<List<AreaData>> getAreaData(Map body);
  Future<GarageData> getGarageData(String body);
  Future<ReserveSpot> reserveSpot(Map body);
}
