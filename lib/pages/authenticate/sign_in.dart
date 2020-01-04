import 'package:flutter/material.dart';
import 'package:todo_list/services/auth.dart';
import 'package:todo_list/shared/constants.dart';
import 'package:todo_list/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toogleAuthenticateScreen;
  SignIn({this.toogleAuthenticateScreen});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
               widget.toogleAuthenticateScreen();
            },
          ),
        ],
      ),
      
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Please enter an email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },         
                decoration: credentialInput.copyWith(labelText: ('Enter your email')),
                ),
                SizedBox(height: 30),
                TextFormField(
                  validator: (val) => val.length < 6 ? "Pasword must has at least 6 characters" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val.trim();
                    });
                  },
                  decoration: credentialInput.copyWith(labelText: ('Enter your password')),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (_formkey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'There was an error signing in';
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}