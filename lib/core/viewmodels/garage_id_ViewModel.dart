import 'dart:async';
import 'package:ahmedapp/core/models/area_data.dart';
import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/core/models/garage_data.dart';
import 'package:ahmedapp/core/models/main_data.dart';
import 'package:ahmedapp/core/models/reserve_spot.dart';
import 'package:ahmedapp/ui/utilities/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmedapp/core/services/api/api.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class GarageIdViewModel extends BaseModel {
  var api = locator<Api>();
  SharedPreferences sharedPreferences;
  List<Place> garageData = new List();

  getGarageData(String id) {
    Timer timer;

    timer = Timer.periodic(
        Duration(seconds: 6), (Timer t) => startingGarageData(id));
  }

  startingGarageData(String id) {
    garageData = [];

    api.getGarageData(id).then((onValue) {
      if (onValue == null) {
        setState(ViewState.Error); // If null indicate we're still fetching
      } else if (onValue.places.length == 0) {
        setState(ViewState.NoDataAvailable);
      } else {
        garageData.addAll(onValue.places);
        setState(ViewState.DataFetched);
      }
    });
  }

  void reserveSpot(String userId, String garageId, String areaId) async {
    var success;
    ReserveSpot data = new ReserveSpot(
      garage_id: garageId,
      place_number: areaId,
      userid: userId,
    );
    try {
      success = await api.reserveSpot(data.toMap());
      setState(ViewState.Idle);
    } catch (e) {
      showSnackBar("Can't reserve the spot" + e.toString());
      success = false;
    }

    print("userId is " + userId);
//    api.reservePlace();
  }
}
