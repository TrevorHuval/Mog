import 'package:firstapp/models/user.dart';
import 'package:flutter/material.dart';
import '../widgets/squat.dart';
import 'bench.dart';
import 'deadlift.dart';
//import '../widgets/bench.dart';
//import '../widgets/deadlift.dart';

class fitnessCalc extends StatefulWidget {
  UserModel loggedInUser;
  fitnessCalc(UserModel this.loggedInUser);

  @override
  _fitnessCalc createState() => _fitnessCalc();
}

class _fitnessCalc extends State<fitnessCalc> {
  @override
  Widget build(BuildContext context) {
    final _TabPages = <Widget>[
      Squat(),
      Bench(),
      Deadlift(),
    ];
    final _Tabs = <Tab>[
      const Tab(icon: Icon(Icons.cloud), text: 'Squat'),
      const Tab(icon: Icon(Icons.alarm), text: 'Bench'),
      const Tab(icon: Icon(Icons.forum), text: 'Deadlift'),
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
  }
}
