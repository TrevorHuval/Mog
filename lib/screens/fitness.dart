// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/fitnessCalc.dart';
import 'package:firstapp/screens/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'split.dart';

class Fitness extends StatefulWidget {
  const Fitness({Key? key}) : super(key: key);
  @override
  _Fitness createState() => _Fitness();
}

class _Fitness extends State<Fitness> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserModel?>(
      stream: UserService(uid: uid).getUserInfo(uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel? userData = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          child: Text("Today's Workout",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 25, top: 25),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).canvasColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: split(),
                                          ));
                                    });
                              },
                              child: const Text(
                                "Edit Split",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 150,
                      width: 500,
                      color: Colors.transparent,
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: SizedBox(
                          height: 75.0,
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => diary(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 75,
                                        height: 75,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/backTargetMuscle.jpg')))),
                                    Container(
                                        width: 75,
                                        height: 75,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/bicepTargetMuscle.jpg')))),
                                  ],
                                ),
                                Container(
                                    height: 50,
                                    width: 150,
                                    child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text("Back & Biceps",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 500,
                      color: Colors.transparent,
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: SizedBox(
                          height: 75.0,
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => fitnessCalc(user),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 90,
                                        height: 90,
                                        margin:
                                            EdgeInsets.fromLTRB(1, 0, 10, 100),
                                      ),
                                      Container(
                                        width: 90,
                                        height: 90,
                                        margin:
                                            EdgeInsets.fromLTRB(1, 10, 1, 10),
                                      ),
                                      Expanded(
                                        child: Text("Deadlift 5/5/5",
                                            style: TextStyle(fontSize: 35),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 20, height: 80),
                        Expanded(
                          //margin: EdgeInsets.symmetric(vertical: 25),
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15))),
                              onPressed: () {},
                              child: Text(
                                'CHECK IN',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          //margin: EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade200,
                                  elevation: 0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15))),
                              onPressed: () {},
                              child: Text(
                                'REST DAY',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20)
                      ],
                    ),
                  ],
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
