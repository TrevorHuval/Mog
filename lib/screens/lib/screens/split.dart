import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class split extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(
              'Arnold Split',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('Back & Chest | Arms & Shoulders | Legs'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'PPL Split',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
                'Push (Chest, Triceps, & Shoulders) |\nPull (Back & Biceps) | Legs'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Bro Split',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Bench | Back & Biceps | Bench | Legs'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
