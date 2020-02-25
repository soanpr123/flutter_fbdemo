import 'package:flutter/material.dart';
import 'package:async/async.dart';
InputDecoration inputDecoration1 = InputDecoration(
    hintText: 'Email'
);
InputDecoration decorationusername = InputDecoration(
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[200],
  filled: true,
  prefixIcon: Icon(
    Icons.mail,
    color: Colors.black,
  ),
);
InputDecoration decorationPassWord = InputDecoration(
  hintText: 'PassWord',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[200],
  filled: true,
  prefixIcon: Icon(
    Icons.lock,
    color: Colors.black,
  ),
);