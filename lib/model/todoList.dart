import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/services/database.dart';
import 'package:todo_list/services/todo.dart';
import 'package:todo_list/model/user.dart';

class TodoList extends StatefulWidget {
  bool showDone = false;
  bool darkTheme = false;
  TodoList({this.showDone, this.darkTheme});
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    final showDone = widget.showDone;
    final darkTheme = widget.darkTheme;
    final user = Provider.of<User>(context);
    final todos = Provider.of<List<Todo>>(context) ?? [];
    final todosNotDone = todos.where((doc) => showDone == doc.done).toList();
    if (todosNotDone.length == 0) 
        return  Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(showDone ? 'You have done nothing' : 'You have nothing todo', 
            style: TextStyle(
              color: darkTheme ? Colors.yellow : Colors.black,
              fontSize: width < 400 ? 20 : 25,
              ),
            ),  
        );
    return Container(
      width: double.infinity,
      child: ListView.builder(
        itemCount: todosNotDone.length,
        itemBuilder: (context, index) {
          //Detect swipe right
          return (todosNotDone[index].done != showDone) ? SizedBox(height:0) : GestureDetector(onPanUpdate: (gesture) {
            if (gesture.delta.dx > 0) {
              DatabaseService(uid: user.uid).makeDone(todosNotDone[index].done, todosNotDone[index].createdTime, todosNotDone[index].plan, todosNotDone[index].time, todosNotDone[index].location);
            }
            else if (gesture.delta.dx < 0) {
              DatabaseService(uid: user.uid).makeDone(todosNotDone[index].done, todosNotDone[index].createdTime, todosNotDone[index].plan, todosNotDone[index].time, todosNotDone[index].location);
            }
          },          
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: darkTheme ? Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(todosNotDone[index].plan,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            )
                          ),
                          if (todosNotDone[index].time.isNotEmpty) Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.access_alarm,
                                    ),
                                  ),
                                  Text(todosNotDone[index].time.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    )
                                  ), 
                                ],
                              ),
                            ),
                          ),
                                                          
                        ],
                      ),
                    ),
                    if (todosNotDone[index].location.isNotEmpty) Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Container(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          Text(todosNotDone[index].location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              )
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ) :
              Container(
                width: double.infinity,
                color: Colors.blue,
                child: Column(
                  children: <Widget>[    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(todosNotDone[index].plan,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            )
                          ),
                          if (todosNotDone[index].time.isNotEmpty) Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.access_alarm,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(todosNotDone[index].time.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    )
                                  ), 
                                ],
                              ),
                            ),
                          ),
                                                          
                        ],
                      ),
                    ),
                    if (todosNotDone[index].location.isNotEmpty) Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Container(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(todosNotDone[index].location,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              )
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}