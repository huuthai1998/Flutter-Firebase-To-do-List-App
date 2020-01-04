import 'package:flutter/material.dart';
import 'package:todo_list/services/auth.dart';
import 'package:todo_list/services/todo.dart';
import 'package:todo_list/services/database.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todoList.dart';
import 'package:todo_list/model/user.dart';
import 'package:todo_list/pages/addTodo.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {  
  
  bool showDone = false;
  bool darkTheme = true;
  String name = '';
  final AuthService _auth = AuthService(); 

  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  final width = queryData.size.width;
  final height = queryData.size.height;

  final user = Provider.of<User>(context);
  final dataReference = DatabaseService(uid : user.uid);
  final data = dataReference.todos;
  name = dataReference.getName();
    return StreamProvider<List<Todo>>.value(
      value: data,
      child: darkTheme ? Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Menu',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(showDone ? Icons.playlist_add : Icons.playlist_add_check, color: Colors.white,),
                  title: Text(showDone ? "Show Not Done List" :'Show Done List',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                    showDone = !showDone;
                  });},
                ),
                SizedBox(height: 20,),
                SwitchListTile(
                  secondary: Icon(Icons.brightness_2, color: Colors.white),
                  title: Text('Dark Theme',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  value: darkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      darkTheme = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.person_outline, color: Colors.white),
                  title: Text('Change name',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blue,
          title: Text('Welcome back${name}!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            FlatButton.icon(
              label: Text("SIGN OUT",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )
              ),
              icon: Icon(Icons.person),
              onPressed: () {
                _auth.signOut();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/addTodo', arguments: {'darkTheme' : darkTheme});
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea( 
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FittedBox(
                    fit: BoxFit.fitWidth, 
                    child: Text(showDone ? "Here are what you have done" : "Here are what you gonna do today",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: width < 400 ? 20 : 25,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TodoList(showDone: showDone, darkTheme: darkTheme),
                ),
              ),
            ],
          ),
        )
      ) :
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Welcome back${name}!'),
          actions: <Widget>[
            FlatButton.icon(
              label: Text("SIGN OUT",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )
              ),
              icon: Icon(Icons.person, color: Colors.white,), 
              onPressed: () {
                _auth.signOut();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: Icon(showDone ? Icons.playlist_add : Icons.playlist_add_check),
                title: Text(showDone ? "Show Not Done List" :'Show Done List',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                  showDone = !showDone;
                });},
              ),
              SizedBox(height: 20,),
              SwitchListTile(
                secondary: Icon(Icons.brightness_2),
                title: Text('Dark Theme',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                value: darkTheme,
                onChanged: (bool value) {
                  setState(() {
                    darkTheme = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Change name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/addTodo', arguments: {'darkTheme' : darkTheme});
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey,
        ),
        body: SafeArea( 
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FittedBox(
                    fit: BoxFit.fitWidth, 
                    child: Text(showDone ? "Here are what you have done" : "Here are what you gonna do today",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width < 400 ? 20 : 25,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    child: TodoList(showDone: showDone, darkTheme: darkTheme),
                  ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
