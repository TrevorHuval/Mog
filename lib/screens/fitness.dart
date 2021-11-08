// ignore_for_file: prefer_const_constructors
import 'package:firstapp/widgets/fitnessCalc.dart';
import 'package:firstapp/screens/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(right: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                context: context,
                                builder: (context) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: split(),
                                      ));
                                });
                          },
                          child: const Text(
                            "Edit Split",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
                        splashFactory: NoSplash.splashFactory,
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
                        splashFactory: NoSplash.splashFactory,
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
