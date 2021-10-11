import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Text("Your Current Group",
                    style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
              ),
              Container(
                  height: 250,
                  width: 500,
                  color: Colors.transparent,
                  child: Card(
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      height: 75.0,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(children: <Widget>[
                              Container(
                                  width: 125,
                                  height: 125,
                                  margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
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
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                  Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/blakeProfilePic.jpg')))),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/anthonyProfilePic.jpg')))),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/bryanProfilePic.jpg'))))
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}

// child: Text(
//            "Home Page",
//           style: TextStyle(fontSize: 20, fontFamily: 'SanFran'),
