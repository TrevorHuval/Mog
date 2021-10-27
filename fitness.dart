// ignore_for_file: prefer_const_constructors
import 'package:firstapp/fitnessCalc.dart';
import 'package:firstapp/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Fitness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Text("Today's workout:",
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
              ),
              Container(
                height: 200,
                width: 500,
                color: Colors.transparent,
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade200,
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
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 90,
                                  height: 90,
                                  margin: EdgeInsets.fromLTRB(5, 10, 10, 100),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/gooberGroupPFP.jpg'),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  margin: EdgeInsets.fromLTRB(5, 10, 10, 100),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/gooberGroupPFP.jpg'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text("Back & Biceps",
                                      style: TextStyle(fontSize: 35),
                                      textAlign: TextAlign.center),
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
              Container(
                height: 250,
                width: 500,
                color: Colors.transparent,
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade200,
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
        ],
      ),
    );
  }
}
