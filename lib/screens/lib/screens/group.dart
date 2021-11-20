import 'package:firstapp/widgets/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../widgets/group_profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.grey.shade100,
                  floating: true,
                  pinned: true,
                  iconTheme: IconThemeData(color: Colors.black),
                  bottom: const TabBar(
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                        icon:
                            Icon(Icons.people_alt_rounded, color: Colors.black),
                      ),
                      Tab(
                          child: Text("Other",
                              style: TextStyle(color: Colors.black)))
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
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/blakeProfilePic.jpg'),
                        ),
                        title: Text('Blake Lalonde'),
                        subtitle: Text('Current Streak: 365'),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/trevorProfilePic.jpg'),
                        ),
                        title: Text('Trevor Huval'),
                        subtitle: Text('Current Streak: 1'),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/bryanProfilePic.jpg'),
                        ),
                        title: Text('Bryan Tran'),
                        subtitle: Text('Current Streak: 0'),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/anthonyProfilePic.jpg'),
                        ),
                        title: Text('Anthony Duong'),
                        subtitle: Text('Current Streak: 32'),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/horacioProfilePic.jpg'),
                        ),
                        title: Text('Horacio Medina'),
                        subtitle: Text('Current Streak: 32'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    shrinkWrap: true,
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
                            //child: Image.asset(imageNames[index])),
                            Text('Checked in'),
                          ],
                        ),
                      );
                      //   return const ListTile(
                      //     leading: CircleAvatar(
                      //       backgroundImage:
                      //           AssetImage('assets/images/' + imageNames[index]),
                      //     ),
                      //     title: Text('Trevor Huval'),
                      //     subtitle: Text('Checked in today at the gym'),
                      // );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
