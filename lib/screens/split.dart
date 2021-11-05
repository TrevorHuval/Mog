// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firstapp/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../group_profile.dart';

class split extends StatelessWidget {
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
                  '\nArnold Split:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Back & Chest | Arms & Shoulders | Legs'),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'PPL Split',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Push (Chest, Triceps, & Shoulders) |\nPull (Back & Biceps) | Legs'),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Bro Split',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Bench | Back & Biceps | Bench | Legs'),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Custom Split',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('Create a custom split'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
