import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/services/todo.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference todoCollection = Firestore.instance.collection('todos');

  Future addUserData(bool done, String plan, String time, String location) async {
    final String date = DateTime.now().toString();
    return await todoCollection.document(uid).collection('taskList').document(date).setData({
      'done' : done,
      'plan' : plan,
      'time' : time,
      'location' : location, 
      'createdTime' : date,
    });
  }

  Future changeName(String name) async {
    return await todoCollection.document(uid).setData({
      'name' : name,
    });
  }
  Future makeDone(bool done, String date, String plan, String time, String location) async {
    DocumentReference doc = todoCollection.document(uid).collection('taskList').document(date);
    if (done == true) {
      return await doc.delete();
    }
    else {
    return await doc.setData({
      'done' : true,
      'plan' : plan,
      'time' : time,
      'location' : location, 
      'createdTime' : date,
    });
    }
  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Todo(
        done: doc.data['done'] ?? false,
        plan: doc.data['plan'] ?? '',
        time: doc.data['time'] ?? '',
        location: doc.data['location'] ?? '',
        createdTime: doc.data['createdTime'] ?? '',
        );
    }).toList();
  }

  String getName() {
    String result = '';
    todoCollection.document(uid).get().then((doc) => 
      result = doc.data['name']
    );
    return result;
  }

  Stream<List<Todo>> get todos {
    return todoCollection.document(uid).collection('taskList').snapshots().map(_todoListFromSnapshot);
  }
}