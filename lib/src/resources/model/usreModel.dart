import 'package:firebase_database/firebase_database.dart';

class User {
  String _id;
  String _email;


  User(this._id,this._email);
  User.fromSnapshot(DataSnapshot snapshot){
    _id=snapshot.key;
    _email=snapshot.value["Email"];
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}