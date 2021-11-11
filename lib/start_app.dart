// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'models/user.dart';
import 'screens/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(startApp());
}

class startApp extends StatefulWidget {
  const startApp({Key? key}) : super(key: key);

  @override
  _startApp createState() => _startApp();
}

class _startApp extends State<startApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
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
            future: _firebaseApp,
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
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<Widget> _children() => [
        Home(),
        Fitness(),
        Progress(),
        Profile(),
        Test(),
      ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    _title = 'Home';
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: children[_currentIndex],
      endDrawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 88,
              width: 500,
              child: DrawerHeader(
                child: Text(
                  "${loggedInUser.firstName} ${loggedInUser.lastName}",
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                decoration: BoxDecoration(color: Colors.red),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.settings_rounded),
                title: Text("Settings",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                AuthService().logout(context);
                //Wrapper();
              },
              child: ListTile(
                leading: Icon(Icons.highlight_remove_rounded),
                title: Text("Sign Out",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            )
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
