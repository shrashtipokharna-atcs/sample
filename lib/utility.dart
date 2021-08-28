import 'package:flutter/material.dart';

getText(textData,txtColor,fontSize){
  return Text(
    textData,
    style: TextStyle(
      color: txtColor,
      fontSize:fontSize,
    ),
  );
}

sendData(name){
  return "Welcome $name";
}