import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GroupProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 75),
              Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage('assets/images/gooberGroupPFP.jpg')))),
              Container(
                  child: Text("Goober",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40)))
            ],
          ),
        ),
      ),
    );
  }
}
