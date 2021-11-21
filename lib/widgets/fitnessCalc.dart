import 'package:flutter/material.dart';

class fitnessCalc extends StatelessWidget {
  fitnessCalc({Key? key}) : super(key: key);
  Widget builtSquat() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        //onChanged: (value) => setState() => squat = value),
      );

  @override
  Widget build(BuildContext context) {
    ;
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.directions_walk), text: 'Squat'),
      const Tab(icon: Icon(Icons.alarm), text: 'Bench'),
      const Tab(icon: Icon(Icons.forum), text: 'Deadlift'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weightlifting Calculator',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red,
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
      ),
    );
  }
}
