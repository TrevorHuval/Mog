import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _Post createState() => _Post();
}

class _Post extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            child: Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/anthonyProfilePic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Anthony Duong",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(" | "),
                                  Text(
                                    "anttonknee",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                "Checked in @ 6:12 PM",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/trevorProfilePic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Trevor Huval",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(" | "),
                                  Text(
                                    "thuval12",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                "Feelin' pretty MOGCHAMP today",
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5),
                                child: Container(
                                  height: 200,
                                  width: 275,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/mogIconRed.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/blakeProfilePic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Blake Lalonde",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(" | "),
                                  Text(
                                    "theblakelalonde",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                "Checked in @ 6:34 PM",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/horacioProfilePic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Horacio Medina",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(" | "),
                                  Text(
                                    "zer0score",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                "Checked in @ 6:50 PM",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/bryanProfilePic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Bryan Tran",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(" | "),
                                  Text(
                                    "btran23",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                "leg day GANG",
                                textAlign: TextAlign.left,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5),
                                child: Container(
                                  height: 200,
                                  width: 275,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/calvesTargetMuscle.jpg'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}