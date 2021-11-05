import 'package:firstapp/group_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'group_profile.dart';

class Group extends StatelessWidget {
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
                  expandedHeight: 215,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Scaffold(
                      backgroundColor: Colors.grey.shade300,
                      body: Container(
                          child: Center(
                        child: GroupProfile(),
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
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: Text('List Item $index'),
                      );
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
