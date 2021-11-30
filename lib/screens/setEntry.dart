import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/services/utils.dart';
import 'package:firstapp/widgets/addSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class setEntry extends StatefulWidget {
  final String exerciseType;
  const setEntry({Key? key, required this.exerciseType}) : super(key: key);

  @override
  _setEntry createState() => _setEntry(exerciseType: exerciseType);
}

class _setEntry extends State<setEntry> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final setsTextHolder = TextEditingController();
  final repsTextHolder = TextEditingController();
  final weightTextHolder = TextEditingController();

  int? numOfSets;
  int? numOfReps;
  int? weight;
  String formattedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

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

  clearTextInput() {
    setsTextHolder.clear();
    repsTextHolder.clear();
    weightTextHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(exerciseType,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              Text("Enter your set(s) information",
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ],
          ),
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
                              controller: setsTextHolder,
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
                              controller: repsTextHolder,
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
                                controller: weightTextHolder,
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
            // Container(
            //   height: 40,
            //   width: 150,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.red,
            //       elevation: 0,
            //       shape: new RoundedRectangleBorder(
            //         borderRadius: new BorderRadius.circular(15),
            //       ),
            //     ),
            //     onPressed: () {
            //       HapticFeedback.lightImpact();
            //       setState(() {
            //         _addWidget();
            //       });
            //     },
            //     child: Text(
            //       'Add Another Set',
            //       style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
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
                onPressed: () async {
                  clearTextInput();
                  String date = formattedDate.replaceAll("/", "_");
                  await UserService(uid: uid).addExercise(
                      date, exerciseType, numOfSets, numOfReps, weight);
                  DatabaseService(uid: uid).buildEventFromDatabase(date);
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
