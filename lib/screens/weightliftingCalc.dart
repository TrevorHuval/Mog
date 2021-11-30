import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/squat.dart';
import '../widgets/bench.dart';
import '../widgets/deadlift.dart';

class fitnessCalc extends StatefulWidget {
  UserModel loggedInUser;
  fitnessCalc(UserModel this.loggedInUser);

  @override
  _fitnessCalc createState() => _fitnessCalc();
}

class _fitnessCalc extends State<fitnessCalc> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: uid).getUserInfo(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            final _TabPages = <Widget>[
              Squat(),
              Bench(),
              Deadlift(),
            ];
            final _Tabs = <Tab>[
              Tab(
                  icon: ImageIcon(AssetImage('assets/images/Squat.png')),
                  text: 'Squat (${userData!.squatPR})'),
              Tab(
                  icon: ImageIcon(AssetImage('assets/images/Bench.png')),
                  text: 'Bench (${userData.benchPR})'),
              Tab(
                  icon: ImageIcon(AssetImage('assets/images/Deadlift.png')),
                  text: 'Deadlift (${userData.deadliftPR})'),
            ];
            return DefaultTabController(
              length: _Tabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Weightlifting Calculator',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  bottom: TabBar(
                    tabs: _Tabs,
                  ),
                ),
                body: TabBarView(
                  children: _TabPages,
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
