import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fbdemo/src/firebase/firebasedata.dart';
import 'package:flutter_fbdemo/src/resources/model/usreModel.dart';
import 'package:random_color/random_color.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyhomeState();
}

abstract class Callback {
  void updateUser(User user);
}

class _MyhomeState extends State<Home> implements Callback {
  bool _anchorToBottom = false;
  FirAuth fiauTh;

  @override
  void initState() {
    super.initState();
    fiauTh = new FirAuth();
    fiauTh.innitState();
  }

  @override
  void dispose() {
    super.dispose();
    fiauTh.dispose();
  }
  @override
  void updateUser(User user) {
    setState(() {
      fiauTh.updateUser(user);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirebaseDataList"),
      ),
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: fiauTh.getUserRef(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: displayUser(snapshot),
          );
        },
      ),
    );
  }

  Widget displayUser(DataSnapshot snapshot) {
    User user = User.fromSnapshot(snapshot);
    var item = new Card(
      child: new Container(
        child: new Center(
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 30.0,
                child: new Text(extraName(user)),
                backgroundColor:
                    new RandomColor().randomColor(colorHue: ColorHue.random),
              ),
              new Expanded(
                  child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            user.email,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.lightBlue),
                          ),
                        ],
                      ))),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.teal,
                      onPressed: () => disPlayDialog(user, false)),
                  new IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.teal,
                      onPressed: () => disPlayDialog(user, false)),
                ],
              )
            ],
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
    );
    return item;
  }

  String extraName(User user) {
    if (!user.email.isEmpty) {
      return user.email.substring(0, 1);
    }
    return "";
  }

  disPlayDialog(User user, bool isEdit) {
    buildDialod(context, this, isEdit, user);
  }

  Future<void> buildDialod(
      BuildContext context, _MyhomeState _myhomeState, bool isedit, User user) {
    final txtEmai = TextEditingController();
    if (user != null) {
      txtEmai.text = user.email;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getTextFied("Email", txtEmai),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("CANCEL"),
              ),
              FlatButton(
                onPressed: () {

                    _myhomeState.updateUser(User(user.id,txtEmai.text));

                    Navigator.of(context).pop();

                },
                child:Text("EDIT") )

            ],
          );
        });
  }

  Widget getTextFied(String email, TextEditingController controller) {
    var editText = new Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        decoration: new InputDecoration(hintText: email),
      ),
    );
    return editText;
  }


}
