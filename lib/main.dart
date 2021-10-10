import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'fitness.dart';
import 'nutrition.dart';
import 'home.dart';
import 'profile.dart';

void main() {
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
        home: MyHomePage(
          title: '',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  String pageTitle = "Default";
  final _pageOptions = [Home(), Fitness(), Nutrition(), Profile()];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("why this shit not working")),
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        onTap: (int i) {
          onTabTapped;
          setState(() {
            selectedPage = i;
          });
        },
        backgroundColor: Colors.red,
        items: const [
          TabItem(icon: Icons.home_rounded, title: 'Home'),
          TabItem(icon: Icons.fitness_center_rounded, title: 'Fitness'),
          TabItem(icon: Icons.local_dining_rounded, title: 'Nutrition'),
          TabItem(icon: Icons.person_rounded, title: 'Profile'),
        ],
        initialActiveIndex: 0,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      selectedPage = index;
      switch (index) {
        case 0:
          {
            pageTitle = "Home";
          }
          break;
        case 1:
          {
            pageTitle = "Fitness";
          }
          break;
        case 2:
          {
            pageTitle = "Nutrition";
          }
          break;
        case 3:
          {
            pageTitle = "Profile";
          }
          break;
      }
    });
  }
}
