import 'dart:async';

import 'package:ahmedapp/core/models/user.dart';
import 'package:ahmedapp/core/services/api/http_api.dart';
import 'package:ahmedapp/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ahmedapp/core/enums/viewstate.dart';
import 'package:ahmedapp/core/models/login.dart';
import 'package:ahmedapp/core/models/registiration_data.dart';
import 'package:ahmedapp/core/services/api/api.dart';
import 'package:ahmedapp/ui/utilities/show_snack_bar.dart';
import 'package:rxdart/rxdart.dart';
import '../../service_locator.dart';
import 'base_model.dart';

class AuthServiceModel extends BaseModel {
  var api = locator<Api>();
  Registration registration;
  Login login;
  UserSignUpData data;
//  StreamController<User> userController = new BehaviorSubject();
  Stream<User> get userStream => HttpApi.userController.stream;

  Future logIn(String email, String password, BuildContext context) async {
    setState(ViewState.Busy);
    var success;
    var hasUser;
    Login loginData = new Login(
      email: email,
      password: password,
    );

    success = await api.logIn(loginData.toMap(), context);
    print("success is " + success.toString());

    hasUser = success != null;

    if (hasUser) {
//      userController.add(success);
      print("the user should be added");
      setState(ViewState.Idle);

//      Navigator.pushReplacementNamed(context, 'homeview');
      return hasUser;
    } else {
      print("Can't Login");
      hasUser = "hghgh";
    }

    return hasUser;
  }

  Future signUp(
      {String phone,
      String car_model,
      String email,
      String password,
      BuildContext context}) async {
    setState(ViewState.Busy);
    var success;

    UserSignUpData data = new UserSignUpData(
      phone: phone,
      email: email,
      car_model: car_model,
      password: password,
    );

    try {
      success = await api.signUp(data.toMap(), context);
      setState(ViewState.Idle);
    } catch (e) {
      showSnackBar("Can't Register" + e.toString());
      success = false;
    }
  }
}
