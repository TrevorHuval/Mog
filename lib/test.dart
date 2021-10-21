import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            "Test Page",
            style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
          ))
        ],
      ),
    );
  }
}
