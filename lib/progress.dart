import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calendar.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'graph.dart';

class Progress extends StatefulWidget {
  @override
  _Progress createState() => _Progress();
}

class _Progress extends State<Progress> {
  var selectedDateMessage = "Select a date";
  String graphTitle = "Weight";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: <Widget>[
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      color: Colors.transparent,
                      height: 400,
                      width: 500,
                      child: Calendar(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Select a date",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20))),
                              onPressed: () {},
                              child: const Text(
                                "Edit Workout",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Card(
                        color: Colors.grey.shade100,
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0,
                            color: Colors.grey.shade100,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: <Widget>[
                              Text("Please select a date to view its workout",
                                  style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.grey))
                            ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      color: Colors.transparent,
                      width: 500,
                      child: Card(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20)),
                        elevation: 0,
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      SimpleDialog(
                                    title: Text('Select graph to view progress',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15)),
                                    children: <Widget>[
                                      ListTile(
                                        title: const Text('Weight'),
                                        onTap: () =>
                                            Navigator.pop(context, 'Weight'),
                                      ),
                                      ListTile(
                                        title: const Text('Bench Press'),
                                        onTap: () => Navigator.pop(
                                            context, 'Bench Press'),
                                      ),
                                      ListTile(
                                        title: const Text('Tricep Extension'),
                                        onTap: () => Navigator.pop(
                                            context, 'Tricep Extension'),
                                      ),
                                    ],
                                  ),
                                ).then((returnVal) {
                                  if (returnVal != null) {
                                    setState(() {
                                      graphTitle = '$returnVal';
                                    });
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(graphTitle,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.grey.shade700,
                                  )
                                ],
                              ),
                            ),
                            Graph(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
