import 'package:flutter/material.dart';

InputDecoration textInputDeco (String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.blueGrey),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}