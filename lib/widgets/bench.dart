import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Bench extends StatefulWidget {
  @override
  _Bench createState() => _Bench();
}

class _Bench extends State<Bench> {
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  late int benchMax;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: UserService(uid: uid).getUserInfo(uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel? userData = snapshot.data;
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll) {
                  overScroll.disallowGlow();
                  return false;
                },
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Warmup Set",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                          Container(
                              child: Row(
                            children: [
                              Text(
                                  " All percentages are\nbased off of 90% 1RPM",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.info_circle,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          ))
                        ],
                      ),
                      SizedBox(height: 20),
                      warmupSet(
                        weight: userData!.benchPR!,
                        percentage: 40,
                      ),
                      SizedBox(height: 20),
                      warmupSet(
                        weight: userData.benchPR!,
                        percentage: 50,
                      ),
                      SizedBox(height: 20),
                      warmupSet(
                        weight: userData.benchPR!,
                        percentage: 60,
                      ),
                      Divider(height: 100),
                      Text("Working Set",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(height: 20),
                      workingSet(
                        weight: userData.benchPR!,
                        percentage: 65,
                        numOfReps: 5,
                      ),
                      SizedBox(height: 20),
                      workingSet(
                        weight: userData.benchPR!,
                        percentage: 75,
                        numOfReps: 5,
                      ),
                      SizedBox(height: 20),
                      workingSet(
                        weight: userData.benchPR!,
                        percentage: 85,
                        numOfReps: 5,
                      )
                    ],
                  ),
                )),
              ),
            ),
          );
        } else {
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class warmupSet extends StatelessWidget {
  int percentage;
  int weight;

  warmupSet({required this.weight, required this.percentage});
  int numOfReps = 5;

  double calculateWeightToLift() {
    return ((weight * .9) * (percentage / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(percentage.toString() + "%",
                style: TextStyle(fontWeight: FontWeight.bold)),
            LinearPercentIndicator(
                width: 150,
                lineHeight: 10,
                percent: (percentage / 100).toDouble(),
                backgroundColor: Colors.white,
                progressColor: Color.fromRGBO(0, 225, 0, 100)),
            Text(
              calculateWeightToLift().toStringAsFixed(0) +
                  " x " +
                  numOfReps.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class workingSet extends StatelessWidget {
  int percentage;
  int weight;
  int numOfReps;
  workingSet(
      {required this.weight,
      required this.percentage,
      required this.numOfReps});

  double calculateWeightToLift() {
    return (((weight * .9) * (percentage / 100)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(percentage.toString() + "%",
                style: TextStyle(fontWeight: FontWeight.bold)),
            LinearPercentIndicator(
              width: 150,
              lineHeight: 10,
              percent: (percentage / 100).toDouble(),
              backgroundColor: Colors.white,
              progressColor: Color.fromRGBO(0, 225, 0, 100),
            ),
            Text(
              calculateWeightToLift().toStringAsFixed(0) +
                  " x " +
                  numOfReps.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
