import 'package:ahmedapp/core/models/area_id.dart';
import 'package:ahmedapp/ui/views/area_id.dart';
import 'package:ahmedapp/ui/views/garage_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ahmedapp/ui/views/home_view.dart';
import 'package:ahmedapp/ui/views/landing_page.dart';
import 'package:ahmedapp/ui/views/sign_up_form.dart';
import 'package:ahmedapp/ui/views/signin_form.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingPage());

      case 'signupform':
        return MaterialPageRoute(builder: (_) => SignUpForm());

      case 'signinformem':
        return MaterialPageRoute(builder: (_) => SignInFormEmailAndPassword());
      case 'areaId':
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => AreaId(id));

      case 'garageId':
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => GarageId(id));

      case 'homeview':
        return MaterialPageRoute(builder: (_) => HomeView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
