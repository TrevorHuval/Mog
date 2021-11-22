import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/models/group.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/group.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GroupProfile extends StatefulWidget {
  String groupid;
  GroupProfile({required this.groupid});
  @override
  _GroupProfile createState() => _GroupProfile(groupid: groupid);
}

class _GroupProfile extends State<GroupProfile> {
  String groupid;
  _GroupProfile({required this.groupid});
  //required String groupid;
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final picker = ImagePicker();
  late File _imageFile;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadGroupImageToFirebase(BuildContext context) async {
    await FirebaseStorage.instance
        .ref()
        .child('groupProfileImages/$groupid')
        .putFile(_imageFile);
    String imageDownloadUrl = await FirebaseStorage.instance
        .ref()
        .child('groupProfileImages/$groupid')
        .getDownloadURL();

    await GroupService(groupid: groupid)
        .updateGroupProfileImage(groupid, imageDownloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: UserService(uid: uid).getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<GroupModel?>.value(
          value: GroupService(groupid: groupid).getGroupInfo(groupid),
          initialData: null,
        )
      ],
      child: Scaffold(
        body: Container(
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    await pickImage();
                    await uploadGroupImageToFirebase(context);
                    setState(() {});
                  },
                  child: groupImage(),
                ),
                groupName()
              ],
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
    return Container(
        child: group == null
            ? Center(child: CircularProgressIndicator())
            : (group.groupImageUrl ==
                    "https://firebasestorage.googleapis.com/v0/b/mogdb-f5659.appspot.com/o/defaultGroupProfileImage.jpg?alt=media&token=ecf67ead-6d9f-46d3-9256-2c3f214f258a"
                ? Container(
                    width: 100,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Text(
                          "Edit Profile Image",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  )
                : Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(group.groupImageUrl),
                      ),
                    ),
                  )));
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
            width: 200,
            height: 75,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("${group.groupName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white))),
          );
  }
}
