import 'dart:io';

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
  String search = 'theblakelalonde';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>?>(
      create: (context) => UserService(uid: uid).queryByUsername(search),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add A Friend',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              search = text;
                            });
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              border: InputBorder.none,
                              filled: false,
                              icon: Icon(CupertinoIcons.search),
                              labelText: 'Search for a username',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        List<UserModel>? list = Provider.of<List<UserModel>?>(
                            context,
                            listen: false);
                        if (list == null) {
                          print("is null");
                        } else {
                          print(list[0].firstName);
                        }

                        // Consumer<List<UserModel>?>(builder: (context, list, _) {
                        //   print(list![0].firstName);
                        //   return SizedBox();
                        // });
                      },
                      child: Text("test")),
                  //ListUsers(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
