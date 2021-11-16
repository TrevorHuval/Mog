import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/group.dart';
import 'package:firstapp/widgets/group_preview.dart';
import 'package:firstapp/widgets/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:firstapp/services/utils.dart';

class Home extends StatefulWidget {
  UserModel loggedInUser;
  Home(UserModel this.loggedInUser);

  @override
  _Home createState() => _Home(loggedInUser);
}

class _Home extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser;
  _Home(UserModel this.loggedInUser);
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                loggedInUser.inGroup == false
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: 500,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15))),
                              child: Text(
                                "CREATE GROUP",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                DatabaseService(uid: uid).createGroup(
                                    loggedInUser.firstName,
                                    loggedInUser.lastName,
                                    "test");
                              },
                            ),
                          ),
                        ),
                      )
                    : groupPreview(),
                /*Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, top: 25),
                      child: Text("Current Group",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left),
                    ),
                    Container(height: 200, width: 500, child: groupPreview())
                  ],
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20, height: 80),
                    Expanded(
                      //margin: EdgeInsets.symmetric(vertical: 25),
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15))),
                          onPressed: () {},
                          child: Text(
                            'CHECK IN',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      //margin: EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade200,
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15))),
                          onPressed: () {},
                          child: Text(
                            'REST DAY',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20)
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade200,
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15))),
                    onPressed: () {
                      print(loggedInUser.firstName);
                      print(loggedInUser.inGroup.toString());
                    },
                    child: Text(
                      'Test',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text("Feed",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return const ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/trevorProfilePic.jpg'),
                        ),
                        title: Text('Trevor Huval'),
                        subtitle: Text('Checked in today at the gym'),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
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

// child: Text(
//            "Home Page",
//           style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
