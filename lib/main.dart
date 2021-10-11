// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'fitness.dart';
import 'nutrition.dart';
import 'home.dart';
import 'profile.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mog',
        theme: ThemeData(
          fontFamily: 'SanFran',
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(
          title: '',
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _title = "default";

  final List<Widget> _children = [
    Home(),
    Fitness(),
    Nutrition(),
    Profile(),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  initState() {
    _title = 'Some default value';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_rounded),
            title: Text('Fitness'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining_rounded),
            title: Text('Nutrition'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Home';
          }
          break;
        case 1:
          {
            _title = 'Fitness';
          }
          break;
        case 2:
          {
            _title = 'Nutrition';
          }
          break;
        case 3:
          {
            _title = 'Profile';
          }
          break;
      }
    });
  }
}
