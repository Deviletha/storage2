import 'package:flutter/material.dart';
import 'package:storage2/sqflite_login/Login%20_Signup.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Login_Signup(),
    );
  }
}