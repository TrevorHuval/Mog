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
    notificationCount = await UserService(uid: uid).getNumFriendRequests();

    setState(() {
      gotNotificationCount = true;
    });
  }

  void getNotifications() async {
    friendRequests = await UserService(uid: uid).getFriendRequests();

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
                child: Container(
                  height: 500,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 10),
                          child: buildFriendRequestList(
                            friendid: friendRequests[index].id,
                          ),
                        );
                      },
                      separatorBuilder: (context, _) => SizedBox(width: 12),
                      itemCount: notificationCount),
                )));
  }
}

class buildFriendRequestList extends StatelessWidget {
  String friendid;
  buildFriendRequestList({required this.friendid});
  final currentUserid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: friendid).getUserInfo(friendid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return GestureDetector(
                onTap: () {},
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
                  ),
                ));
          } else {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
