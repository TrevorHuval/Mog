import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/notifications.dart';
import 'package:firstapp/services/user.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        },
      ),
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
  final AuthService _atuhService = AuthService();
  late List<Widget> children = _children();

  @override
  void initState() {
    _title = 'Home';
    super.initState();
  }

  List<Widget> _children() => [
        Home(),
        Fitness(),
        Progress(),
        Profile(),
      ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<UserModel?>(
        stream: UserService(uid: uid).getUserInfo(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Notifications()));
                        },
                        child: Icon(CupertinoIcons.bell_fill)),
                  ],
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
                          "${userData!.firstName} ${userData.lastName}",
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
                        leading: Icon(CupertinoIcons.gear_alt_fill),
                        title: Text("Settings",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _atuhService.logout(context);
                      },
                      child: ListTile(
                        leading: Icon(CupertinoIcons.square_arrow_left),
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
                    icon: Icon(CupertinoIcons.house_fill),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fitness_center_rounded),
                    title: Text('Fitness'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.graph_circle_fill),
                    title: Text('Progress'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_fill),
                    title: Text('Profile'),
                  ),
                ],
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
