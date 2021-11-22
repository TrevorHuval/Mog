import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriends createState() => _AddFriends();
}

class _AddFriends extends State<AddFriends> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> searchedUsers = [];
  bool gotUsers = false;
  int searchedUsersCount = 0;
  String search = '';
  bool submitSearch = false;

  @override
  void initState() {
    updateSearchList();
    super.initState();
  }

  void updateSearchList() async {
    if (search.isEmpty == false) {
      searchedUsers = await UserService(uid: uid).queryByUsername(search);
      searchedUsersCount = searchedUsers.length;
      gotUsers = true;
      setState(() {});
      print(searchedUsersCount.toString());
      print(searchedUsers[0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add A Friend', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              onChanged: (text) {
                                setState(() {
                                  search = text;
                                  submitSearch = false;
                                });
                              },
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8),
                                  border: InputBorder.none,
                                  filled: false,
                                  //icon: Icon(CupertinoIcons.search),
                                  labelText: 'Search for a username',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                              onTap: () {
                                if (search.isEmpty) {
                                  setState(() {
                                    submitSearch = false;
                                    gotUsers = false;
                                  });
                                } else {
                                  setState(() {
                                    gotUsers = false;
                                    submitSearch = true;
                                  });
                                }
                                updateSearchList();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Center(
                                      child: Icon(CupertinoIcons.search,
                                          color: Colors.white)))),
                        )
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       List<UserModel>? list = Provider.of<List<UserModel>?>(
                //           context,
                //           listen: false);
                //       if (list == null) {
                //         print("is null");
                //       } else {
                //         print(list[0].firstName);
                //       }
                //       // Consumer<List<UserModel>?>(builder: (context, list, _) {
                //       //   print(list![0].firstName);
                //       //   return SizedBox();
                //       // });
                //     },
                //     child: Text("test")),
                gotUsers == false
                    ? submitSearch == false
                        ? SizedBox()
                        : Container(
                            color: Colors.white,
                            child: Center(child: CircularProgressIndicator()))
                    : Container(
                        height: 200,
                        // child: Center(child: Text("Build Test idfk")),
                        child: ListView.separated(
                          separatorBuilder: (context, _) => SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            return listUsers(userid: searchedUsers[index].id);
                          },
                          itemCount: searchedUsersCount,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class listUsers extends StatelessWidget {
  String userid;
  listUsers({required this.userid});
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: UserService(uid: userid).getUserInfo(userid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel? userData = snapshot.data;
          return GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userData!.profileImageUrl),
                ),
                title: Text(userData.firstName! + " " + userData.lastName!),
                subtitle: Text(userData.username!),
                trailing: SizedBox(
                  width: 30,
                  height: 30,
                  child: GestureDetector(
                      onTap: () {
                        UserService(uid: uid).sendFriendRequest(userid);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Center(
                              child: Icon(CupertinoIcons.add,
                                  size: 18, color: Colors.white)))),
                ),
              ));
        } else {
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
