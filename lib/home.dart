import 'package:firstapp/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  Widget buildProfilePics() => Container(
      width: 37,
      height: 37,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
                        child: Text("Current Group",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          height: 200,
                          width: 500,
                          color: Colors.transparent,
                          child: Card(
                            color: Colors.grey.shade200,
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: InkWell(
                              splashColor: Colors.grey,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Group()));
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
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 15, 0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    'assets/images/gooberGroupPFP.jpg')))),
                                    // Group Name
                                    Container(
                                      width: 175,
                                      height: 75,
                                      child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text("Goober",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ])),
                                  Expanded(
                                      child: ListView.separated(
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 20,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 12),
                                    itemBuilder: (context, index) =>
                                        buildProfilePics(),
                                  )),
                                ],
                              ),
                            ),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
                        child: Text("Feed",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                child: ListView.builder(
                    itemCount: 20,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/trevorProfilePic.jpg'),
                        ),
                        title: Text('Trevor Huval'),
                        subtitle: Text('Checked in today at the gym'),
                      );
                    }),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          }),
    ]));
  }
}

// child: Text(
//            "Home Page",
//           style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
