import 'package:ahmedapp/service_locator.dart';
import 'package:ahmedapp/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/models/user.dart';
import 'core/services/api/scaffold_service.dart';
import 'core/viewmodels/authntication_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      lazy: true,
      child: MaterialApp(
        title: 'ahmed App',
        theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Colors.green[800],
            accentColor: Colors.grey[600]),
        initialRoute: 'landing',
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<ScaffoldService>().navigatorKey,
        debugShowCheckedModeBanner: false,
      ),
      create: (context) => locator<AuthServiceModel>().userStream,
    );
  }
}
