import 'package:flutter/material.dart';
import 'package:todo_list/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/user.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return (user != null) ? Home() : Authenticate();
  }
}