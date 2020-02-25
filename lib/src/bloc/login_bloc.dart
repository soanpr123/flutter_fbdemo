import 'dart:async';

import 'package:flutter_fbdemo/src/firebase/firebasedata.dart';
import 'package:flutter_fbdemo/src/validators/validater.dart';





class LoginBloc {
  var _auTh= FirAuth();
  StreamController _Usercontroller = new StreamController();
  StreamController _Passcontroller = new StreamController();

  Stream getUser() {
    return _Usercontroller.stream;
  }

  Stream getPassword() {
    return _Passcontroller.stream;
  }

  bool isValidaInfo(String username, String Password) {
    if (!Validation.isvaliUser(username)) {
      _Usercontroller.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _Usercontroller.sink.add("ok");
    if (!Validation.isvaliPass(Password)) {
      _Passcontroller.sink.addError("Mật Khẩu phải trên 6 kí tự");
      return false;
    }

    _Passcontroller.sink.add("ok");
    return true;
  }
void SignUp(String Email,String PassWord, Function onSucces,Function (String ) onRegisterErr){
    _auTh.singup(Email, PassWord, onSucces,onRegisterErr);
}
void Sign(String Email,String PssWord, Function onSucces,Function (String ) onRegisterErr){
    _auTh.Sign(Email, PssWord, onSucces, onRegisterErr);
}
  void Isclose(){
    _Usercontroller.close();
    _Passcontroller.close();
  }
}
