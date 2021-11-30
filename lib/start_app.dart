import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/notifications.dart';
import 'package:firstapp/services/user.dart';
import 'package:firstapp/widgets/calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'models/user.dart';
import 'screens/all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth.dart';
import 'package:badges/badges.dart';

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
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int _currentIndex = 0;
  String _title = "";
  User? user = FirebaseAuth.instance.currentUser;
  final AuthService _authService = AuthService();
  late List<Widget> children = _children();
  bool gotNotificationCount = false;
  String notificationCountStr = "";

  @override
  void initState() {
    _title = 'Home';
    getNotificationCount(uid);
    super.initState();
  }

  List<Widget> _children() => [
        Home(),
        Fitness(),
        Progress(),
        Profile(),
      ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  void getNotificationCount(uid) async {
    int notificationCount = await UserService(uid: uid).getNumFriendRequests() +
        await UserService(uid: uid).getNumPokes();
    setState(() {
      notificationCountStr = notificationCount.toString();
      gotNotificationCount = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: UserService(uid: uid).getUserInfo(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userData = snapshot.data;
            return gotNotificationCount == true
                ? Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Notifications()));
                              },
                              child: Badge(
                                  badgeContent: Text(notificationCountStr,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  badgeColor: Colors.white,
                                  padding: EdgeInsets.all(4),
                                  child: Icon(CupertinoIcons.bell_fill))),
                        ],
                      ),
                      backgroundColor: Colors.red,
                    ),
                    body: children[_currentIndex],
                    endDrawer: Drawer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 85,
                            child: DrawerHeader(
                              child: Text(
                                "${userData!.firstName} ${userData.lastName}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              //decoration: BoxDecoration(color: Colors.red),
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
                              _authService.logout(context);
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
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.fitness_center_rounded),
                          label: "Fitness",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.graph_circle_fill),
                          label: "Progress",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person_fill),
                          label: "Profile",
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
            ;
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
