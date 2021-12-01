import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/create_group.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/friendsList.dart';
import 'package:firstapp/widgets/group_preview.dart';
import 'package:firstapp/widgets/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: UserService(uid: uid).getUserInfo(uid),
          initialData: null,
        )
      ],
      child: StreamBuilder<UserModel?>(
        stream: UserService(uid: uid).getUserInfo(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
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
                        buildFriendsList(),
                        userData!.inGroup == false
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20),
                                  child: Container(
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15),
                                                ),
                                              ),
                                              child: Text(
                                                "CREATE GROUP",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CreateGroup(),
                                                  ),
                                                );
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
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
                                          child: SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  15))),
                                              child: Text(
                                                "JOIN GROUP",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : groupPreview(uidForGroup: uid),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            UserService(uid: uid).updateNotificationCount(uid);
                          },
                          child: Text("Test"),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     UserService(uid: uid).decreaseNotificationCount();
                        //   },
                        //   child: Text("decrease"),
                        // ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text("Feed",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 20),
                            Post(
                              name: "Anthony Duong",
                              username: "AntTonKnee",
                              caption:
                                  "We takin over the gym today! @bryantran1 @theblakelalonde @thuval2 @hmedin2",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/anthonyProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Bryan Tran",
                              username: "bryantran1",
                              caption: "The boys killed it today yessir",
                              media: true,
                              mediaURL: "assets/images/groupPic.jpg",
                              profileImage: "assets/images/bryanProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Kathleen Dinh",
                              username: "klean",
                              caption: "amazing leg day!!",
                              media: true,
                              mediaURL: "assets/images/kathleenFlex.jpg",
                              profileImage:
                                  "assets/images/kathleenProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Bryan Tran",
                              username: "bryantran1",
                              caption:
                                  "every push day, i get closer to boulder shoulders.  the grind really don't stop man!",
                              media: true,
                              mediaURL: "assets/images/bryanShoulder.jpg",
                              profileImage: "assets/images/bryanProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Trevor Huval",
                              username: "thuval2",
                              caption: "Amazing 3hr sesh",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/trevorProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                                name: "Horacio Medina",
                                username: "hmedin2",
                                caption: "big lifter guy",
                                media: false,
                                mediaURL: "",
                                profileImage:
                                    "assets/images/horacioProfilePic.jpg"),
                            Divider(height: 20),
                            Post(
                              name: "Blake Lalonde",
                              username: "theblakelalonde",
                              caption: "Just PR'd for 500 squat!",
                              media: false,
                              mediaURL: "",
                              profileImage: "assets/images/blakeProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Anthony Duong",
                              username: "AntTonKnee",
                              caption:
                                  "Checked in @ 5:30 PM, got a good leg day in",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/anthonyProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Abigail Glass",
                              username: "abigailGlass",
                              caption: "Squats go harddd",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/abigailProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Bryan Tran",
                              username: "bryantran1",
                              caption: "I literally hate legs omg",
                              media: false,
                              mediaURL: "",
                              profileImage: "assets/images/bryanProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Kathleen",
                              username: "klean",
                              caption: "an insane pull day pump",
                              media: true,
                              mediaURL: "assets/images/kathleenBack.jpg",
                              profileImage:
                                  "assets/images/kathleenProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Bryan Tran",
                              username: "bryantran1",
                              caption: "Checked in @ 9:59 PM",
                              media: true,
                              mediaURL: "assets/images/bryanTricep.jpg",
                              profileImage: "assets/images/bryanProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Trevor Huval",
                              username: "thuval2",
                              caption:
                                  "got a good at home workout in, no skips for me",
                              media: true,
                              mediaURL: "assets/images/trevorAtHome.jpg",
                              profileImage:
                                  "assets/images/trevorProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Horacio Medina",
                              username: "hmedin2",
                              caption: "gym boutta go dummy hard",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/horacioProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Blake Lalonde",
                              username: "theblakelalonde",
                              caption: "Tris for Guys",
                              media: false,
                              mediaURL: "",
                              profileImage: "assets/images/blakeProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Anthony Duong",
                              username: "AntTonKnee",
                              caption: "Big Pump today :p",
                              media: true,
                              mediaURL: "assets/images/antFlex.jpg",
                              profileImage:
                                  "assets/images/anthonyProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Bryan Tran",
                              username: "bryantran1",
                              caption: "Deadlifting demon you already know",
                              media: false,
                              mediaURL: "",
                              profileImage: "assets/images/bryanProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Trevor Huval",
                              username: "thuval2",
                              caption: "The grind don't stop",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/trevorProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Anthony Duong",
                              username: "AntTonKnee",
                              caption:
                                  "That boy @theblakelalonde pressure at the gym",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/anthonyProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Blake Lalonde",
                              username: "theblakelalonde",
                              caption: "Let's get this shit",
                              media: false,
                              mediaURL: "",
                              profileImage: "assets/images/blakeProfilePic.jpg",
                            ),
                            Divider(height: 20),
                            Post(
                              name: "Horacio",
                              username: "hmedin2",
                              caption: "Possible PR day??",
                              media: false,
                              mediaURL: "",
                              profileImage:
                                  "assets/images/horacioProfilePic.jpg",
                            ),
                            Divider(height: 20),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class buildFriendsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    return Container(
      width: 400,
      height: 100,
      child: friendList(),
    );
  }
}
