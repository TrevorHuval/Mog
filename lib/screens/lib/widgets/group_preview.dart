import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/group.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/group.dart';
import 'package:firstapp/services/group.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class groupPreview extends StatefulWidget {
  const groupPreview({Key? key}) : super(key: key);

  @override
  _groupPreview createState() => _groupPreview();
}

class _groupPreview extends State<groupPreview> {
  // Widget buildProfilePics() => Container(
  //     width: 37,
  //     height: 37,
  //     decoration: const BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white,
  //         image: DecorationImage(
  //             fit: BoxFit.contain,
  //             image: AssetImage('assets/images/blakeProfilePic.jpg'))));
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

  @override
  Widget build(BuildContext context) {
    return gotUserGroups == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MultiProvider(
            providers: [
              StreamProvider<UserModel?>.value(
                value: UserService(uid: uid).getUserInfo(uid),
                initialData: null,
              ),
              StreamProvider<GroupModel?>.value(
                value: GroupService(groupid: userGroups[0].id)
                    .getGroupInfo(userGroups[0].id),
                initialData: null,
              )
            ],
            child: Container(
              height: 150,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Group(groupid: userGroups[0].id)));
                    },
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                              groupImage(),
                              groupName(),
                            ])),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class groupImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    GroupModel? group = Provider.of<GroupModel?>(context);
    return group == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(group.groupImageUrl))));
  }
}

class groupName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    GroupModel? group = Provider.of<GroupModel?>(context);
    return group == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: 175,
            height: 75,
            child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("${group.groupName}",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          );
  }
}



// USEFUL CODE TO GET DOCIDS OF GROUPS INSIDE USER
/*List<DocumentSnapshot> documents =
                                  await DatabaseService(uid: uid)
                                      .getUserGroups();*/
