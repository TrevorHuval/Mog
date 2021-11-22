import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/group.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/group.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../widgets/group_profile.dart';
import 'friendProfile.dart';

class Group extends StatefulWidget {
  String groupid;
  Group({required this.groupid});

  @override
  _Group createState() => _Group(groupid: groupid);
}

class _Group extends State<Group> {
  final String groupid;
  _Group({required this.groupid});
  List<String> imageNames = [
    'assets/images/trevorProfilePic.jpg',
    'assets/images/blakeProfilePic.jpg',
    'assets/images/anthonyProfilePic.jpg',
    'assets/images/horacioProfilePic.jpg',
    'assets/images/bryanProfilePic.jpg',
  ];
  List<DocumentSnapshot> groupMembers = [];
  bool gotMembers = false;
  int memberCount = 0;

  @override
  void initState() {
    downloadGroupMembers();
    super.initState();
  }

  void downloadGroupMembers() async {
    groupMembers = await GroupService(groupid: groupid).getGroupMemberIDs();
    memberCount = groupMembers.length;
    gotMembers = true;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return gotMembers == false
        ? NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [SliverAppBar()];
            },
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator())),
          )
        : MultiProvider(
            providers: [
              StreamProvider<GroupModel?>.value(
                value: GroupService(groupid: groupid).getGroupInfo(groupid),
                initialData: null,
              )
            ],
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                body: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          backgroundColor: Colors.red,
                          floating: true,
                          pinned: true,
                          iconTheme: IconThemeData(color: Colors.white),
                          bottom: const TabBar(
                            indicatorColor: Colors.white,
                            tabs: [
                              Tab(
                                icon: Icon(Icons.people_alt_rounded,
                                    color: Colors.white),
                              ),
                              Tab(
                                icon: Icon(CupertinoIcons.square_stack_fill,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          expandedHeight: 300,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Scaffold(
                              backgroundColor: Colors.grey.shade300,
                              body: Container(
                                  child: Center(
                                child: GroupProfile(
                                  groupid: groupid,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        NotificationListener<OverscrollIndicatorNotification>(
                            onNotification:
                                (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowGlow();
                              return false;
                            },
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return displayMember(
                                      memberid: groupMembers[index].id);
                                },
                                separatorBuilder: (context, _) =>
                                    SizedBox(width: 12),
                                itemCount: memberCount)),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.separated(
                            shrinkWrap: false,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: imageNames.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: new EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(imageNames[index]),
                                        ),
                                      ),
                                    ),
                                    Text('Checked in'),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class displayMember extends StatelessWidget {
  String memberid;
  displayMember({required this.memberid});
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    GroupModel? group = Provider.of<GroupModel?>(context);

    return group == null
        ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : StreamBuilder<UserModel?>(
            stream: UserService(uid: memberid).getUserInfo(memberid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? memberData = snapshot.data;
                return GestureDetector(
                    onTap: () {
                      if (uid == memberid) {
                        null;
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    friendProfile(friendid: memberid)));
                      }
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(memberData!.profileImageUrl),
                      ),
                      title: Text(
                          memberData.firstName! + " " + memberData.lastName!),
                      subtitle: Text(
                          "Current streak: " + memberData.streak.toString()),
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }
}
