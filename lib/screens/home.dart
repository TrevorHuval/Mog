import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/create_group.dart';
import 'package:firstapp/screens/group.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/friendsList.dart';
import 'package:firstapp/widgets/group_preview.dart';
import 'package:firstapp/widgets/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:firstapp/services/utils.dart';
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
    //final user = Provider.of<UserModel>(context);

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
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text("Feed",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
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
                                  backgroundImage: AssetImage(
                                      'assets/images/trevorProfilePic.jpg'),
                                ),
                                title: Text('Trevor Huval'),
                                subtitle: Text('Checked in today at the gym'),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
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

// child: Text(
//            "Home Page",
//           style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
