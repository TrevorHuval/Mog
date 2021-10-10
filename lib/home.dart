import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
              child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Your Current Group",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
              ),
              Container(
                  height: 350,
                  width: 500,
                  color: Colors.transparent,
                  child: Card(
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.all(20.0),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      height: 75.0,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        child: Row(
                          children: const <Widget>[
                            Expanded(
                              child: Text("Goobers",
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center),
                            ),
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