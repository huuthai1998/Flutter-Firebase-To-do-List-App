import 'package:flutter/material.dart';
import 'package:todo_list/pages/authenticate/sign_in.dart';
import 'package:todo_list/pages/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isRegeistering = false;
  void toogleAuthenticateScreen() {
    setState(() {
      isRegeistering = !isRegeistering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isRegeistering ? Register(toogleAuthenticateScreen: toogleAuthenticateScreen) 
    : SignIn(toogleAuthenticateScreen: toogleAuthenticateScreen);
  }
}