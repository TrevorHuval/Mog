// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'fitness.dart';
import 'home.dart';
import 'test.dart';
import 'profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'progress.dart';
import 'settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mog',
        theme: ThemeData(
          fontFamily: 'SanFran',
          primarySwatch: Colors.red,
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error building! ${snapshot.error.toString()}');
                return Text('Something went wrong :(');
              } else if (snapshot.hasData) {
                return HomePage(
                  title: '',
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        //HomePage(
        //title: '',
        );
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
    Progress(),
    Profile(),
    Test(),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  initState() {
    _title = 'Home';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: _children[_currentIndex],
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          // backgroundColor: Colors.grey,
          children: <Widget>[
            SizedBox(
              height: 127,
              child: DrawerHeader(
                // child: CircleAvatar(),
                child: Text(
                  'theanthonyduong',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.red),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings', style: TextStyle(fontSize: 25)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.highlight_remove),
              title: Text('Sign out', style: TextStyle(fontSize: 25)),
              onTap: () {},
            ),
          ],
        ),
      ),
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
            icon: Icon(Icons.bar_chart_rounded),
            title: Text('Progress'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_rounded),
            title: Text('Test'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(
      () {
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
              _title = 'Progress';
            }
            break;
          case 3:
            {
              _title = 'Profile';
            }
            break;
          case 4:
            {
              _title = 'Test';
            }
        }
      },
    );
  }
}
