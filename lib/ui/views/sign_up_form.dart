import 'package:ahmedapp/core/viewmodels/authntication_model.dart';
import 'package:ahmedapp/ui/utilities/validator.dart';
import 'package:ahmedapp/ui/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'base_widget.dart';

class SignUpForm extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<SignUpForm> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> form = GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController carModelController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthServiceModel>(
        model: AuthServiceModel(),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                key: _scaffoldstate,
                appBar: new AppBar(
                  title: new Text('Sign Up'),
                ),
                body: _getListUi(
                    model,
                    _formKey,
                    emailController,
                    passwordController,
                    phoneController,
                    carModelController,
                    context)));
  }
}

Widget _getListUi(
    AuthServiceModel model,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController phoneController,
    TextEditingController carModelController,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(20.0),
    child: Form(
      key: formKey,
      child: new ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          FormInput(
            validator: (value) =>
                Validators(name: 'Email Address', value: value)
                    .compose([Validators.required, Validators.email]),
            controller: emailController,
            icon: FontAwesomeIcons.envelope,
            hintText: "Email Address",
            keyboardType: TextInputType.emailAddress,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FormInput(
              validator: (value) =>
                  Validators(name: 'Password', value: value).compose([
                Validators.required,
              ]),
              controller: passwordController,
              icon: FontAwesomeIcons.expand,
              hintText: "Password",
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FormInput(
              validator: (value) =>
                  Validators(name: 'mobile number is required', value: value)
                      .compose([
                Validators.required,
              ]),
              controller: phoneController,
              icon: FontAwesomeIcons.expand,
              hintText: "phone number",
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FormInput(
              validator: (value) =>
                  Validators(name: 'car model', value: value).compose([
                Validators.required,
              ]),
              controller: carModelController,
              icon: FontAwesomeIcons.expand,
              hintText: "car model",
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          ButtonTheme(
            minWidth: 4.0,
            child: new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () async {
                formKey.currentState.save();
                if (!formKey.currentState.validate()) return;
                var loginSuccess = await model.signUp(
                  email: emailController.text,
                  context: context,
                  password: passwordController.text,
                  phone: phoneController.text,
                  car_model: carModelController.text,
                );
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
