import 'package:firstapp/models/user.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final _TabPages = <Widget>[
      Squat(),
      Bench(),
      Deadlift(),
    ];
    final _Tabs = <Tab>[
      Tab(
          icon: ImageIcon(AssetImage('assets/images/Squat.png')),
          text: 'Squat'),
      Tab(
          icon: ImageIcon(AssetImage('assets/images/Bench.png')),
          text: 'Bench'),
      Tab(
          icon: ImageIcon(AssetImage('assets/images/Deadlift.png')),
          text: 'Deadlift'),
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
