import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            initialData: null,
            child:
                MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()),
          );
        }
        return Directionality(
            textDirection: TextDirection.ltr, child: Text("Loading"));
      },
    );
  }
}
