import 'package:flutter/material.dart';
import 'package:todo_list/pages/addTodo.dart';
import 'package:todo_list/pages/home.dart';
import 'package:todo_list/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/user.dart';
import 'package:todo_list/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/addTodo': (context) => AddTodo(),
        },
      ),
    );
  }
}