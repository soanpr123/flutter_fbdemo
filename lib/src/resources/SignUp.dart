import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fbdemo/src/bloc/login_bloc.dart';
import 'package:flutter_fbdemo/src/resources/dialog/Loading.dart';
import 'package:flutter_fbdemo/src/resources/LoginPage.dart';
import 'package:flutter_fbdemo/src/resources/dialog/msg_dialog.dart';

import 'HomePage.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpStatePage createState() => _SignUpStatePage();
}

class _SignUpStatePage extends State<SignUpPage> {
  bool loading= false;

  LoginBloc bloc = new LoginBloc();

  TextEditingController _userC = new TextEditingController();
  TextEditingController _passC = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                child: FlutterLogo()),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: StreamBuilder(
                  stream: bloc.getUser(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    controller: _userC,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: StreamBuilder(
                  stream: bloc.getPassword(),
                  builder: (context, snapshot) => TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    controller: _passC,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  color: Colors.orange,
                  onPressed: Onsignclick,
                  child: Text("SIGNUP"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Onsignclick() {
    if (bloc.isValidaInfo(_userC.text, _passC.text)) {
LoadingDialog.showLoadingDialog(context, "Loading....."); 
      bloc.SignUp(_userC.text, _passC.text, (){
LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },(msg){
LoadingDialog.hideLoadingDialog(context);
MsgDialog.showMsgDialog(context, "Lỗi", msg);
      });

    }
  }

  Widget getHome(BuildContext context) {
    return LoginPage();
  }
}
