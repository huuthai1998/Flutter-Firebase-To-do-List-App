import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/model/user.dart';
import 'package:todo_list/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  //register user with email and password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService data = DatabaseService(uid: user.uid);
      await data.changeName(name);
      await data.addUserData(false, 'Your first plan', '', '');
      return _userFromFireBaseUser(user);
    } 
    catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

        //await DatabaseService(uid: user.uid).updateUserData();
      return _userFromFireBaseUser(user);
    }
    catch(e) {
      print(e.toString());
    }
  }
  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in anonymously
  Future signInAnonymous() async {
    try {
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
}