import 'package:flutter/material.dart';
import 'package:flutter_fbdemo/src/bloc/login_bloc.dart';
import 'package:flutter_fbdemo/src/resources/LoginPage.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: LoginPage(),
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}
