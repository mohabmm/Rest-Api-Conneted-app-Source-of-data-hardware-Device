import 'dart:async';
import 'package:ahmedapp/core/models/area_data.dart';
import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmedapp/core/services/api/api.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class AreaIdViewModel extends BaseModel {
  var api = locator<Api>();
  SharedPreferences sharedPreferences;
  List<AreaData> areaData = new List();

  getAreaData(String id) {
    Timer timer;

    timer = Timer.periodic(Duration(seconds: 6), (Timer t) => startingData(id));
  }

  startingData(String id) {
    areaData = [];

    AreaIdModel data = new AreaIdModel(
      id: id,
    );

    api.getAreaData(data.toMap()).then((onValue) {
      if (onValue == null) {
        setState(ViewState.Error); // If null indicate we're still fetching
      } else if (onValue.length == 0) {
        setState(ViewState.NoDataAvailable);
      } else {
        areaData.addAll(onValue);
        setState(ViewState.DataFetched);
      }
    });
  }

  void reserveArea(String areaId) {
// api.reserveGarage(areaId);
  }
}
