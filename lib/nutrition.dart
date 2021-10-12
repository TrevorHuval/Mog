// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nutrition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // mainAxisAlignment: MainAxisAlignment.center,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(50, 25, 50, 0),
                child: Text("Today",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              Container(
                width: 500,
                height: 150,
                color: Colors.transparent,
                child: Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Ant")
                    ],),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
