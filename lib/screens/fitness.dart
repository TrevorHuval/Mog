// ignore_for_file: prefer_const_constructors
import 'package:firstapp/fitnessCalc.dart';
import 'package:firstapp/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/fitness2.dart';
import 'split.dart';

class Fitness extends StatefulWidget {
  const Fitness({Key? key}) : super(key: key);
  @override
  _Fitness createState() => _Fitness();
}

class _Fitness extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 25),
                      child: Text("Today's Workout",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => split(),
                            ),
                          );
                        },
                        child: const Text(
                          "Edit Split",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 150,
                  width: 500,
                  color: Colors.transparent,
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade100,
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      height: 75.0,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => diary(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 75,
                                    height: 75,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/backTargetMuscle.jpg')))),
                                Container(
                                    width: 75,
                                    height: 75,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/bicepTargetMuscle.jpg')))),
                              ],
                            ),
                            Container(
                                height: 50,
                                width: 150,
                                child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Back & Biceps",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: 500,
                  color: Colors.transparent,
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade100,
                    margin: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      height: 75.0,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => fitnessCalc(),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 90,
                                    height: 90,
                                    margin: EdgeInsets.fromLTRB(1, 0, 10, 100),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 90,
                                    margin: EdgeInsets.fromLTRB(1, 10, 1, 10),
                                  ),
                                  Expanded(
                                    child: Text("Deadlift 5/5/5",
                                        style: TextStyle(fontSize: 35),
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
