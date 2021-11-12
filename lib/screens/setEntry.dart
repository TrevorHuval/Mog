// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:ui';

import 'package:firstapp/widgets/addSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class setEntry extends StatefulWidget {
  const setEntry({Key? key}) : super(key: key);

  @override
  _setEntry createState() => _setEntry();
}

class _setEntry extends State<setEntry> {
  int numberOfWidgets = 1;

  List<Widget> generateWidgets(numberOfWidgets) {
    final exerciseWidgets = List<Widget>.generate(
      10,
      (numberOfWidgets) => Container(
        height: 150,
        child: Column(
          children: [
            Container(height: 75, child: addSet()),
            Text("$numberOfWidgets")
          ],
        ),
      ),
    );
    return exerciseWidgets;
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
                      'Iso-Lateral Pulldowns (hardcoded)',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: numberOfWidgets,
                    key: UniqueKey(),
                    itemBuilder: (),
                  )
                )
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
                    setState(() {
                      numberOfWidgets = numberOfWidgets + 1;
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
                  onPressed: () {},
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
          )),
    );
  }
}
