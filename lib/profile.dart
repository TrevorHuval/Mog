// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/group.dart';

class Profile extends StatelessWidget {
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Container for the profile information
                  Container(
                    width: 500,
                    height: 175,
                    // alignment: Alignment.topCenter,
                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 100,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/anthonyProfilePic.jpg'),
                                      ),
                                    ),
                                  ),
                                  Column(children: <Widget>[
                                    Container(
                                      height: 45,
                                      width: 185,
                                      margin: EdgeInsets.only(top: 30),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "Anthony Duong",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      width: 185,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          "Height: 5'8",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      width: 185,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          "Weight: 170",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 20,
                                      width: 185,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          "Sex: Male",
                                        ),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Favorite Groups container
                  Container(
                      height: 200,
                      width: 500,
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Group()));
                          },
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height:
                                    15, // Creates margin inside the card for the group pic and name
                              ),
                              Expanded(
                                  child: Row(children: <Widget>[
                                // Group Image
                                Container(
                                    width: 125,
                                    height: 125,
                                    margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                'assets/images/gooberGroupPFP.jpg')))),
                                // Group Name
                                Container(
                                  width: 175,
                                  height: 75,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text("Goober",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                              ])),
                              Expanded(
                                  child: ListView.separated(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                scrollDirection: Axis.horizontal,
                                itemCount: 20,
                                separatorBuilder: (context, _) =>
                                    SizedBox(width: 12),
                                itemBuilder: (context, index) =>
                                    buildProfilePics(),
                              )),
                            ],
                          ),
                        ),
                      )),

                  // Max Calculations container
                  Container(
                    width: 500,
                    height: 175,
                    // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "\nMax Calculations",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              "Benchpress: 105lbs\nSquat: 135lbs\nDeadlift: 185lbs\nGoal: 415/1000lbs",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//       // Side menu for settings and misc
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             SizedBox(
//               height: 127,
//               child: DrawerHeader(
//                 // child: CircleAvatar(),
//                 child: Text(
//                   'theanthonyduong',
//                   style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
//                 ),
//                 decoration: BoxDecoration(color: Colors.red.shade900),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.settings, size: 40),
//               title: Text('Settings', style: TextStyle(fontSize: 25)),
//               onTap: () {},
//             ),
//             Spacer(),
//             ListTile(
//               leading: Icon(Icons.highlight_remove, size: 40),
//               title: Text('Sign out', style: TextStyle(fontSize: 25)),
//               onTap: () {},
//             ),
//           ],
//         ),
      // ),
    // );
  // }
// }
