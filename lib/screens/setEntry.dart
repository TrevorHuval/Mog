// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class setEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Enter Set Information'), backgroundColor: Colors.red),
        body: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          left: 25,
                          top: 30,
                          right: 25,
                        ),
                        child: Text(
                          'Iso-Lateral Pulldowns (hardcoded)',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 75,
                    width: 500,
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        // padding: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Center(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sets:',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    height: 35,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        maxLines: 1,
                                        decoration: InputDecoration.collapsed(
                                            hintText: '0'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Reps:',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    height: 35,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        maxLines: 1,
                                        decoration: InputDecoration.collapsed(
                                            hintText: '0'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Weight:',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    height: 35,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        maxLines: 1,
                                        decoration: InputDecoration.collapsed(
                                            hintText: '0'),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    // Row to align buttons
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 20, height: 80),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add Set',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Save Set',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20)
                    ],
                  ),
                  SizedBox(
                    // A buffer to keep the screen at the top
                    height: 500,
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
