import 'dart:async';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmedapp/core/services/api/api.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  var api = locator<Api>();
  SharedPreferences sharedPreferences;
  List<MainData> mainGarages = new List();

  getHomeData() {
    Timer timer;

    timer = Timer.periodic(Duration(seconds: 6), (Timer t) => startingData());
  }

  startingData() {
    mainGarages = [];

    api.getMainData().then((onValue) {
      if (onValue == null) {
        setState(ViewState.Error); // If null indicate we're still fetching
      } else if (onValue.length == 0) {
        setState(ViewState.NoDataAvailable);
      } else {
        mainGarages.addAll(onValue);
        setState(ViewState.DataFetched);
      }
    });
  }
}
