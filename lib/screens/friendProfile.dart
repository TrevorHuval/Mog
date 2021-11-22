import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/group_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';

class friendProfile extends StatefulWidget {
  final String friendid;
  const friendProfile({Key? key, required this.friendid}) : super(key: key);
  @override
  _friendProfile createState() => _friendProfile(friendid: friendid);
}

class _friendProfile extends State<friendProfile> {
  String friendid;
  _friendProfile({required this.friendid});
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int total = 0;

  final picker = ImagePicker();

  int getTotal(int benchPR, int squatPR, int deadliftPR) {
    total = benchPR + squatPR + deadliftPR;
    if (total > 1000) {
      total = 1000;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: friendid).getUserInfo(friendid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Text(
                              "Remove friend",
                              style: TextStyle(fontSize: 20),
                            ),
                            content: Text(
                              "Are you sure you want to remove \n ${userData!.firstName} ${userData.lastName} as a friend?",
                              style: TextStyle(fontSize: 15),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Cancel"),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "Remove"),
                                  child: const Text("Remove")),
                            ],
                          ),
                        ).then((returnVal) async {
                          if (returnVal != null) {
                            if (returnVal == "Remove") {
                              await UserService(uid: uid)
                                  .removeFriend(friendid);
                              Navigator.pop(context);
                            }
                          }
                        });
                      },
                      child: Icon(
                          CupertinoIcons.person_crop_circle_fill_badge_xmark,
                          size: 30),
                    ),
                  )
                ],
              ),
              body: Scaffold(
                backgroundColor: Colors.white,
                body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowGlow();
                    return false;
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        width: 500,
                        height: 175,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Card(
                          elevation: 0,
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          context;
                                          setState(() {});
                                        },
                                        child: userData!.profileImageUrl ==
                                                "https://firebasestorage.googleapis.com/v0/b/mogdb-f5659.appspot.com/o/defaultUserProfileImage.jpg?alt=media&token=b4da1c1b-7bf4-4b88-ad07-946044b7d295"
                                            ? Container(
                                                width: 100,
                                                height: 50,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Column(
                                                  children: [
                                                    Icon(Icons
                                                        .camera_alt_rounded),
                                                    Text("Edit Profile Image",
                                                        style: TextStyle(
                                                            fontSize: 12))
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: 100,
                                                height: 100,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(userData
                                                        .profileImageUrl),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 185,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                "${userData.firstName} ${userData.lastName}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(userData.username!,
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey)),
                                          Divider(
                                            height: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: FittedBox(
                                                  child: Text(
                                                    "Height: ${userData.feet}'${userData.inches}",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: FittedBox(
                                                  child: Text(
                                                    "Weight: ${userData.weight}",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15,
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: FittedBox(
                                                  child: Text(
                                                    "Sex: ${userData.sex}",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                        child: const Text("Max Calculations",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                      ),

                      // Max Calculations container
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Card(
                          elevation: 0,
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 125,
                                    height: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Bench:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                        Text("${userData.benchPR}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 125,
                                    height: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Squat:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                        Text("${userData.squatPR}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 125,
                                    height: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Deadlift:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                        Text("${userData.deadliftPR}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LinearPercentIndicator(
                                    width: 140,
                                    lineHeight: 14,
                                    percent: getTotal(
                                            userData.benchPR!.toInt(),
                                            userData.squatPR!.toInt(),
                                            userData.deadliftPR!.toInt()) /
                                        1000,
                                    //center: Text("425 / 1000"),
                                    backgroundColor: Colors.grey.shade300,
                                    progressColor:
                                        Color.fromRGBO(0, 255, 0, 100),
                                  ),
                                  SizedBox(height: 5),
                                  total < 1000
                                      ? Text(
                                          "$total / 1000",
                                          style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700,
                                              fontSize: 10),
                                        )
                                      : Text(
                                          "$total / 1000 \n Congratulations on hitting the 1K Club!",
                                          style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700,
                                              fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      userData.inGroup == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    "Invite To Group",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                                      child: const Text("Group",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left),
                                    ),
                                    groupPreview(uidForGroup: friendid),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
