import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'fitness.dart';
import 'nutrition.dart';
import 'social.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SanFran',
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mog Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  final _pageOptions = [Fitness(), Nutrition(), Social(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.red,
        items: [
          TabItem(icon: Icons.fitness_center_rounded, title: 'Fitness'),
          TabItem(icon: Icons.local_dining_rounded, title: 'Nutrition'),
          TabItem(icon: Icons.group_rounded, title: 'Social'),
          TabItem(icon: Icons.person_rounded, title: 'Profile'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
