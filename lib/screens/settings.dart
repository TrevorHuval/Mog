import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  Widget build(BuildContext context) {
    return Center(
      child: Text("settings page"),
    );
  }
}
