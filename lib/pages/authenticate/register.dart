import 'package:flutter/material.dart';
import 'package:todo_list/services/auth.dart';
import 'package:todo_list/shared/constants.dart';
import 'package:todo_list/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toogleAuthenticateScreen;
  Register({this.toogleAuthenticateScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
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
                  validator: (val) => val.isEmpty ? "Please enter your name" : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },         
                decoration: credentialInput.copyWith(labelText: ("Please enter your name")),
                ),
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
                TextFormField(
                  validator: (val) => val != password ? "Pasword does not match" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      confirmPassword = val.trim();
                    });
                  },
                  decoration: credentialInput.copyWith(labelText: ('Enter your password again')),
                ),
                SizedBox(height: 30),
                RaisedButton(
                   child: Text('Register'),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'There was an error registering';
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