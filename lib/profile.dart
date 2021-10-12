// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade700,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                // Container for the profile information
                Container(
                  width: 500,
                  height: 175,
                  // alignment: Alignment.topCenter,
                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  margin: EdgeInsets.fromLTRB(15, 45, 15, 0),
                  child: Card(
                    color: Colors.grey.shade300,
                    elevation: 10,
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
                                  margin: EdgeInsets.fromLTRB(20, 0, 25, 0),
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
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "\nAnthony Duong",
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Height: 5'8\nWeight: 170lbs\nSex: Male",
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                ),
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
                  width: 500,
                  height: 175,
                  // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Card(
                    color: Colors.grey.shade300,
                    elevation: 10,
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
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/gooberGroupPFP.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "\nFavorite Group",
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Goober",
                                        style: TextStyle(fontSize: 25),
                                        textAlign: TextAlign.start,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Max Calculations container
                Container(
                  width: 500,
                  height: 175,
                  // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  margin: EdgeInsets.fromLTRB(15, 30, 15, 10),
                  child: Card(
                    color: Colors.grey.shade300,
                    elevation: 10,
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
        ],
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
