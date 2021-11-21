import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/group.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/friendProfile.dart';
import 'package:firstapp/screens/group.dart';
import 'package:firstapp/services/group.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class friendList extends StatefulWidget {
  const friendList({
    Key? key,
  }) : super(key: key);

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
  bool gotUserGroups = false;

  @override
  void initState() {
    downloadUserGroups();
    super.initState();
  }

  void downloadUserGroups() async {
    userGroups = await DatabaseService(uid: uid).getUserGroups();
    gotUserGroups = true;
    setState(() {});
  }

  List<String> friendsList = [
    "sldpI3CzUQdwAsDofuTQeaoi46j1",
    "jaBgmfROxuOSgqtaSgaGKjo7YID3",
    "GUrKdhn5KmWCsOS2LkZYWOwOkQn1",
    "DpKthRxuAcZqykaiJufjdbOW3zQ2",
  ];

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {},
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
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center))
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: friendsList.length,
                        separatorBuilder: (context, _) => SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return friendPreview(friendid: friendsList[index]);
                        })),
              ],
            ));
  }
}

class friendPreview extends StatelessWidget {
  String friendid;
  friendPreview({required this.friendid});

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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                friendProfile(friendid: friendid)));
                  },
                  child: Container(
                    height: 90,
                    width: 80,
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
                                    fontSize: 12, fontWeight: FontWeight.bold),
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

// USEFUL CODE TO GET DOCIDS OF GROUPS INSIDE USER
/*List<DocumentSnapshot> documents =
                                  await DatabaseService(uid: uid)
                                      .getUserGroups();*/