import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/user.dart';
import 'package:todo_list/shared/loading.dart';
import 'package:todo_list/shared/constants.dart';
import 'package:todo_list/services/database.dart';

class AddTodo extends StatefulWidget {
  @override 
  AddTodoState createState() => AddTodoState();
}

class AddTodoState extends State <AddTodo> {
  Map data = {};
  int key;
  bool loading = false;
  String plan;
  String time;
  String location;
  String createdTime;
  dynamic _formKey = GlobalKey<FormState>();
  
  @override 
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    final darkTheme = data['darkTheme'];
    final user = Provider.of<User>(context);
    return loading ? Loading() : !darkTheme ? Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Add new plan',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('Enter your plan'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.black,
                        )
                      ),
                    ),
                    validator: (val) {
                      return val.isEmpty ? "Plan must not be empty" : null;
                    },
                    onSaved: (String value) {
                      plan = value;
                    },
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('When are you gonna do it?'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.black,
                        )
                      ),
                    ),
                     onSaved: (val) {
                      time = val;
                    },
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('Where is it?'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.black,
                        )
                      ),
                    ),
                     onSaved: (val) {
                      location = val;
                    },
                  ),
                ), 
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await DatabaseService(uid: user.uid).addUserData(
                                false, 
                                plan ?? '',
                                time ?? '', 
                                location ?? ''
                                );
                              setState(() {
                                loading = true;
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Done",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                   ),
                ),
                SizedBox(height: 20,),
              ],
          ),
        ),
      )
    ) : 
    Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Add new plan',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('Enter your plan'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.white,
                        )
                      ),
                    ),
                    validator: (val) {
                      return val.isEmpty ? "Plan must not be empty" : null;
                    },
                    onSaved: (String value) {
                      plan = value;
                    },
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('When are you gonna do it?'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.white,
                        )
                      ),
                    ),
                     onSaved: (val) {
                      time = val;
                    },
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: addTodoForm.copyWith(
                      labelText: ('Where is it?'),
                      labelStyle: (
                        TextStyle(
                          color: Colors.white,
                        )
                      ),
                    ),
                     onSaved: (val) {
                      location = val;
                    },
                  ),
                ), 
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await DatabaseService(uid: user.uid).addUserData(
                                false, 
                                plan ?? '',
                                time ?? '', 
                                location ?? ''
                                );
                              setState(() {
                                loading = true;
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                   ),
                ),
                SizedBox(height: 20,),
              ],
          ),
        ),
      )
    );
  }
}