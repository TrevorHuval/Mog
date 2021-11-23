import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/screens/diary.dart';

class todaysWorkout extends StatefulWidget {
  const todaysWorkout({Key? key}) : super(key: key);

  @override
  _todaysWorkout createState() => _todaysWorkout();
}

class _todaysWorkout extends State<todaysWorkout> {
  DateTime day = DateTime.now();
  String? userSet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 500,
      color: Colors.transparent,
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 75.0,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => diary(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
