import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<Notifications> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> friendRequests = [];
  int numFriendRequests = 0;
  List<DocumentSnapshot> pokes = [];
  int numPokes = 0;

  int notificationCount = 0;
  bool gotNotificationCount = false;
  bool gotNotifications = false;

  @override
  void initState() {
    getNumNotifications();
    getNotifications();
    super.initState;
  }

  void getNumNotifications() async {
    numFriendRequests = await UserService(uid: uid).getNumFriendRequests();
    numPokes = await UserService(uid: uid).getNumPokes();

    setState(() {
      gotNotificationCount = true;
    });
  }

  void getNotifications() async {
    friendRequests = await UserService(uid: uid).getFriendRequests();
    pokes = await UserService(uid: uid).getPokes();

    setState(() {
      gotNotifications = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: (gotNotificationCount == false || gotNotifications == false)
            ? Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()))
            : MultiProvider(
                providers: [
                    StreamProvider<UserModel?>.value(
                      value: UserService(uid: uid).getUserInfo(uid),
                      initialData: null,
                    )
                  ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      numFriendRequests == 0
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Friend Requests",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return buildFriendRequestList(
                                        friendid: friendRequests[index].id,
                                      );
                                    },
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 12),
                                    itemCount: numFriendRequests),
                                SizedBox(height: 40),
                              ],
                            ),
                      numPokes == 0
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Pokes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text("Swipe to dismiss",
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return buildPokes(
                                        friendid: pokes[index].id,
                                      );
                                    },
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 12),
                                    itemCount: numPokes),
                              ],
                            ),
                    ],
                  ),
                )));
  }
}

class buildFriendRequestList extends StatefulWidget {
  String friendid;
  buildFriendRequestList({required this.friendid});
  @override
  _buildFriendRequestList createState() =>
      _buildFriendRequestList(friendid: friendid);
}

class _buildFriendRequestList extends State<buildFriendRequestList> {
  String friendid;
  _buildFriendRequestList({required this.friendid});
  final currentUserid = FirebaseAuth.instance.currentUser!.uid;
  bool selectedAnswer = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: friendid).getUserInfo(friendid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return selectedAnswer == false
                ? ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userData!.profileImageUrl),
                    ),
                    title: Text(userData.firstName! +
                        " " +
                        userData.lastName! +
                        " (" +
                        userData.username! +
                        ")"),
                    subtitle: Text("sent you a friend request"),
                    trailing: SizedBox(
                      width: 75,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                                onTap: () async {
                                  await UserService(uid: currentUserid)
                                      .acceptFriendRequest(friendid);
                                  setState(() {
                                    selectedAnswer = true;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                    child: Center(
                                        child: Icon(
                                            CupertinoIcons.checkmark_alt,
                                            size: 18,
                                            color: Colors.white)))),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                                onTap: () async {
                                  await UserService(uid: currentUserid)
                                      .declineFriendRequest(friendid);
                                  setState(() {
                                    selectedAnswer = true;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: Center(
                                        child: Icon(CupertinoIcons.xmark,
                                            size: 18, color: Colors.white)))),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          } else {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

class buildPokes extends StatelessWidget {
  String friendid;
  buildPokes({required this.friendid});
  final currentUserid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: friendid).getUserInfo(friendid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return Dismissible(
              key: Key("pokeItem"),
              onDismissed: (direction) async {
                await UserService(uid: currentUserid).dismissPoke(friendid);
              },
              child: SizedBox(
                width: 200,
                height: 50,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userData!.profileImageUrl),
                  ),
                  title: Text(userData.firstName! +
                      " " +
                      userData.lastName! +
                      " checked in at the gym!"),
                ),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
