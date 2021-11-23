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
          title: Text('Choose a workout to edit',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
                  'Back Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Deadlift',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Deadlift',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Dumbbell Lateral Raises',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Dumbbell Lateral Raises',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Iso-Lateral High Rows',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Iso-Lateral Pulldowns',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Iso-Lateral Pulldowns',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Pull-Ups',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Pull-Ups',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Seated Rows',
                      ),
                    ),
                  );
                },
              ),
              // Spacer
              ListTile(
                title: Text(
                  'Bicep Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Alternate Dumbbell Curls',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Alternate Dumbell Curls',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Curling Bar',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Hammer Heads',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Inclined Hammer Curls',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Inclined Hammer Curls',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Seated Bicep Curl',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Seated Bicep Curl',
                      ),
                    ),
                  );
                },
              ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Bench Press',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Cable Flies',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Dip Machine',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Dip Machine',
                      ),
                    ),
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
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Inclined Dumbbell Press',
                      ),
                    ),
                  );
                },
              ),
              //Spacer
              ListTile(
                title: Text(
                  'Leg Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Dumbbell Lunges',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Dumbbell Lunges',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Leg Extensions',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Leg Extensions',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Leg Press',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Leg Press',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Squats',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Squats',
                      ),
                    ),
                  );
                },
              ),
              // Spacer
              ListTile(
                title: Text(
                  'Tricep Workouts:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              ListTile(
                title: Text(
                  'Overhead Dumbbell Extensions',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Overhead Dumbbell Extensions',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Overhead Rope Extensions',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Overhead Rope Extensions',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Pushdowns',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Pushdowns',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Skull Crushers',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => setEntry(
                        exerciseType: 'Skull Crushers',
                      ),
                    ),
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
