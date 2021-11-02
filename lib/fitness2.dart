// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firstapp/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fitness2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 150,
                    //alignment: Alignment.center,
                    //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.transparent,
                    child: Card(
                      // child: Text(
                      //   "\n\nAdd Exercise\n(Needs fix)",
                      //   style: TextStyle(fontSize: 20),
                      //   textAlign: TextAlign.center,
                      // ),
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => diary(),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              //height: 100,
                              child: Text(
                                "\nAdd Exercise\n(Needs to be fixed)",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
