import 'package:firstapp/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  Widget buildProfilePics() => Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/blakeProfilePic.jpg'))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
                        child: Text("Current Group:",
                            style: TextStyle(fontSize: 17),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          height: 250,
                          width: 500,
                          color: Colors.transparent,
                          child: Card(
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            elevation: 7,
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
                                    Container(
                                        width: 125,
                                        height: 125,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 25, 0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/gooberGroupPFP.jpg')))),
                                    Expanded(
                                      child: Text("Goober",
                                          style: TextStyle(fontSize: 40),
                                          textAlign: TextAlign.start),
                                    ),
                                  ])),
                                  Expanded(
                                      child: ListView.separated(
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 6,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 12),
                                    itemBuilder: (context, index) =>
                                        buildProfilePics(),
                                  )),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// child: Text(
//            "Home Page",
//           style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
