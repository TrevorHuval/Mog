// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:ui';

import 'package:firstapp/widgets/addSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class setEntry extends StatefulWidget {
  final String exerciseType;
  const setEntry({Key? key, required this.exerciseType}) : super(key: key);

  @override
  _setEntry createState() => _setEntry(exerciseType: exerciseType);
}

class _setEntry extends State<setEntry> {
  final String exerciseType;
  _setEntry({Key? key, required this.exerciseType});
  int numberOfWidgets = 1;
  bool canRemove = false;
  List<Widget> exerciseWidgets = <Widget>[addSet()];

  _addWidget() {
    Widget newSet = addSet();
    exerciseWidgets.add(newSet);
    setState(() => this.canRemove = true);
  }

  _removeWidget() {
    if (exerciseWidgets.length > 1) {
      exerciseWidgets.removeLast();
      if (exerciseWidgets.length == 1) {
        setState(() => this.canRemove = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Enter Set Information',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      exerciseType,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: exerciseWidgets,
                ),
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: canRemove
                        ? () {
                            HapticFeedback.lightImpact();
                            setState(() {
                              _removeWidget();
                            });
                          }
                        : null,
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _addWidget();
                  });
                },
                child: Text(
                  'Add Another Set',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
                child: Text(
                  'Save Workout',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
