import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            "Profile Page",
            style: new TextStyle(fontSize: 20, fontFamily: 'SanFran'),
          ))
        ],
      ),
    );
  }
}
