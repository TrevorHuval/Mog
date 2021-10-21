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
          title: Text('Back and Biceps'),
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
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral Pulldowns',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 4 | Reps: 10 | 45lbs',
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral High Rows',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 3 | Reps: 10 | 110lbs',
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Seated Rows',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 4 | Reps: 10 | 85lbs',
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Bicep Workouts:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ListTile(
                title: Text(
                  'Seated Biceps',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 3 | Reps: 10 | 45lbs',
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Hammer Heads',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 3 | Reps: 10 | 25lbs',
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Pullups',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Sets: 3 | Reps: 10',
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
