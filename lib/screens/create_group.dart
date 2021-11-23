import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroup createState() => _CreateGroup();
}

class _CreateGroup extends State<CreateGroup> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String? groupName;
  final picker = ImagePicker();
  File? profileImage;
  bool createGroupButtonActive = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(
      () {
        final isButtonActive = controller.text.isNotEmpty;

        setState(() => this.createGroupButtonActive = isButtonActive);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Future getImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        profileImage = File(PickedFile.path);
      }
    });
  }

  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: UserService(uid: uid).getUserInfo(uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel? userData = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.pop(context);
                              },
                              child: const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child:
                                      Icon(Icons.arrow_back_ios_new_rounded)),
                            ),
                            Text("Create A Group",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30)),
                            const SizedBox(width: 25)
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 550,
                          width: 500,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Group Name:",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Focus(
                                      child: TextFormField(
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.red),
                                        maxLines: 1,
                                        decoration: InputDecoration.collapsed(
                                            hintText: 'Enter your group name'),
                                        onChanged: (val) {
                                          setState(() {
                                            groupName = val;
                                          });
                                        },
                                      ),
                                      onFocusChange: (hasFocus) {
                                        if (!hasFocus) {
                                          if (groupName != null &&
                                              groupName != "") {
                                            setState(() =>
                                                this.createGroupButtonActive =
                                                    true);
                                          } else {
                                            setState(() =>
                                                this.createGroupButtonActive =
                                                    false);
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const Divider(height: 20),
                              SizedBox(height: 40),
                              ElevatedButton(
                                child: const Text("Create Group",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: createGroupButtonActive
                                    ? () async {
                                        await DatabaseService(uid: uid)
                                            .createGroup(groupName!);
                                        Navigator.pop(context);
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      )
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
    );
  }
}
