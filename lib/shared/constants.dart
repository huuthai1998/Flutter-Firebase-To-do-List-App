import 'package:flutter/material.dart';

dynamic addTodoForm =  InputDecoration(
  labelStyle: (
    TextStyle(
      color: Colors.white,
    )
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.blue),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.blue)
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.pink),
  ),
  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
);

dynamic credentialInput = InputDecoration(
  fillColor: Colors.grey,
  filled: true,
    border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink),
  ),
  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
);