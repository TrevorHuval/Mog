// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../widgets/group_profile.dart';
import 'setEntry.dart';

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral High Rows',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Seated Rows',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Hammer Heads',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Curling Bar',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Inclined Dumbbell Press',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Cable Flies',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => setEntry()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
