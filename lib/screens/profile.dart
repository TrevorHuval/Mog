import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/screens/group.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  UserModel loggedInUser;
  Profile(UserModel this.loggedInUser);

  @override
  _Profile createState() => _Profile(loggedInUser);
}

class _Profile extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser;
  _Profile(UserModel this.loggedInUser);
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  /*
  ADD PROFILE IMAGE TO USER STARTER

  SizedBox(
    height: 100,
    width: 100,
    child: TextButton(
      onPressed: () => getImage(),
      child: profileImage == null
          ? Icon(Icons.camera_alt_rounded)
          : Container(
              width: 100,
              height: 100,
              margin:
                  EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(profileImage!)),
              ),
            ),
      ),
  ),
*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  // Container for the profile information

                  Container(
                    width: 500,
                    height: 175,
                    // alignment: Alignment.topCenter,
                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade200,
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
                                            'assets/images/defaultUserProfileImage.jpg'),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 185,
                                        height: 70,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            "${loggedInUser.firstName} ${loggedInUser.lastName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: FittedBox(
                                              child: Text(
                                                "Height: ${loggedInUser.feet}'${loggedInUser.inches}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 15,
                                                  //fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: FittedBox(
                                              child: Text(
                                                "Weight: ${loggedInUser.weight}",
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 15,
                                                  //fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: FittedBox(
                                              child: Text(
                                                "Sex: ${loggedInUser.sex}",
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                    Text("105 lbs",
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
                                    Text("135 lbs",
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
                                    Text("185 lbs",
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
                                percent: 0.425,
                                //center: Text("425 / 1000"),
                                backgroundColor: Colors.grey.shade300,
                                progressColor: Color.fromRGBO(0, 255, 0, 100),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "425 / 1000",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: const Text("Group",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                  ),
                  Container(
                      height: 200,
                      width: 500,
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
