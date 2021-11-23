import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/add_friend.dart';
import 'package:firstapp/screens/friendProfile.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class friendList extends StatefulWidget {
  friendList({
    Key: UniqueKey,
  }) : super();

  @override
  _friendList createState() => _friendList();
}

class _friendList extends State<friendList> {
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> userGroups = [];
  List<DocumentSnapshot> friends = [];
  bool gotUserGroups = false;
  bool gotFriends = false;

  @override
  void initState() {
    downloadUserGroups();
    getFriends();
    super.initState();
  }

  void downloadUserGroups() async {
    userGroups = await DatabaseService(uid: uid).getUserGroups();
    gotUserGroups = true;
    setState(() {});
  }

  void getFriends() async {
    friends = await UserService(uid: uid).getUserFriends();
    gotFriends = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return gotUserGroups == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamProvider<UserModel?>.value(
            value: UserService(uid: uid).getUserInfo(uid),
            initialData: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                friends.length == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddFriends()))
                              .then((_) => setState(() {}));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.person_add_solid,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 80,
                                    height: 20,
                                    child: Text("Add A Friend",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            scrollDirection: Axis.horizontal,
                            itemCount: friends.length,
                            separatorBuilder: (context, _) =>
                                SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              return friendPreview(
                                  friendid: friends[index].id, index: index);
                            })),
              ],
            ));
  }
}

class friendPreview extends StatefulWidget {
  int index;
  String friendid;
  friendPreview({required this.friendid, required this.index});
  @override
  _friendPreview createState() =>
      _friendPreview(index: index, friendid: friendid);
}

class _friendPreview extends State<friendPreview> {
  int index;
  String friendid;
  _friendPreview({required this.friendid, required this.index});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return user == null
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder<UserModel?>(
            stream: UserService(uid: friendid).getUserInfo(friendid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? friendData = snapshot.data;
                return index == 0
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddFriends()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        CupertinoIcons.person_add_solid,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 80,
                                      height: 20,
                                      child: Text("Add A Friend",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => friendProfile(
                                              friendid: friendid)))
                                  .then((value) => setState(() {}));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(friendData!
                                                  .profileImageUrl)))),
                                  Container(
                                      width: 80,
                                      height: 15,
                                      child: Text(
                                          "${friendData.firstName} ${friendData.lastName}",
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center))
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      friendProfile(friendid: friendid)));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              friendData!.profileImageUrl)))),
                              Container(
                                  width: 80,
                                  height: 20,
                                  child: Text(
                                      "${friendData.firstName} ${friendData.lastName}",
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center))
                            ],
                          ),
                        ),
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }
}
