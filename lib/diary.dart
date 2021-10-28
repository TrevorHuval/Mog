// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firstapp/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'group_profile.dart';

class diary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose a workout to edit'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          // child: NotificationListener<OverscrollIndicatorNotification>(
          //   onNotification: (OverscrollIndicatorNotification overScroll) {
          //     overScroll.disallowGlow();
          //     return false;
          //   },
          // ),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  '\nBack Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral Pulldowns',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral High Rows',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Seated Rows',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              //
              // Spacer
              ListTile(
                title: Text(
                  'Bicep Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Seated Bicep Curl',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Hammer Heads',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Curling Bar',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              //
              // Spacer
              ListTile(
                title: Text(
                  'Chest Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Bench Press',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Inclined Dumbbell Press',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Cable Flies',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
