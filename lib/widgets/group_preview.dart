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
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Future<List<DocumentSnapshot>> documents =
        DatabaseService(uid: uid).getUserGroups();
    String groupid = documents[0].id;

    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: UserService(uid: uid).getUserInfo(uid),
          initialData: null,
        ),
        // StreamProvider<GroupModel?>.value(
        //   value: GroupService(uid: uid).getGroupInfo(uid),
        //   initialData: null,
        // )
      ],
      child: Container(
        height: 200,
        color: Colors.transparent,
        child: Card(
          elevation: 0,
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Group()));
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
                  groupName(),
                ])),
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  separatorBuilder: (context, _) => SizedBox(width: 12),
                  itemBuilder: (context, index) => buildProfilePics(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class groupName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    GroupModel? group = Provider.of<GroupModel?>(context);
    return Container(
      width: 175,
      height: 75,
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("${user!.firstName} ${user.lastName}",
              style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}


// USEFUL CODE TO GET DOCIDS OF GROUPS INSIDE USER
/*List<DocumentSnapshot> documents =
                                  await DatabaseService(uid: uid)
                                      .getUserGroups();*/
