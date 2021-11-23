import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/user.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int? numOfSets;
  int? numOfReps;
  int? weight;
  String? date = "11_23_2021";

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
            child: Container(
              height: 100,
              child: Scaffold(
                body: SizedBox(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 75,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  numOfSets = int.parse(value);
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10),
                                  ),
                                  labelText: 'Sets',
                                  labelStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 75,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  numOfReps = int.parse(value);
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10),
                                  ),
                                  labelText: 'Reps',
                                  labelStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 75,
                            child: TextFormField(
                                enableInteractiveSelection: false,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    weight = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    labelText: 'Weight',
                                    labelStyle: TextStyle(fontSize: 15))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                  UserService(uid: uid).addExercise(
                      date, exerciseType, numOfSets, numOfReps, weight);
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
