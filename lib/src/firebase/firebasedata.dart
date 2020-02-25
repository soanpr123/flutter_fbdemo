import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_fbdemo/src/resources/model/usreModel.dart';

class FirAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseReference _userref;
  StreamSubscription<Event> _messageStreamSubscription;
  FirebaseDatabase _database = new FirebaseDatabase();
  DatabaseError err;
  static final FirAuth _intanse = new FirAuth.internal();
  FirAuth.internal();
  factory FirAuth() {
    return _intanse;
  }
  void singup(String Email, String PassWord, Function onSucces,
      Function(String) onRegisterErr) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: Email, password: PassWord)
        .then((user) {
      _createUser(user.user.uid, Email, onSucces, onRegisterErr);
      print(user);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterErr);
    });
  }

  void Sign(String Email, String PassWord, Function onSucces,
      Function(String) onRegisterErr) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: Email, password: PassWord)
        .then((user) {
      print("Thành công");
      onSucces();
    }).catchError((err) {
      onRegisterErr("Sigin Faild,pleass try again");
    });
  }

  _createUser(String userID, String Email, Function onSucces,
      Function(String) onRegisterErr) {
    var user = {"Email": Email};
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userID).set(user).then((v1) {
      print("on value: SUCCESSED");
      onSucces();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterErr("SignUp fail, please try again");
    }).whenComplete(() {
      print("completed");
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  void innitState() {
    _userref = _database.reference().child("users");
    _database.setPersistenceEnabled(true);
    _database.setPersistenceCacheSizeBytes(1024 * 1000000);
  }

  DatabaseError getError() {
    return err;
  }

  void updateUser(User user) async {
    var updatedt = {"Email": user.email};
    await _userref.child(user.id).update(updatedt).then((_) {
      print("Update success");
    });
  }

  DatabaseReference getUserRef() {
    return _userref;
  }

  void dispose() {
    _messageStreamSubscription.cancel();
  }
}
