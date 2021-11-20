import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class addSet extends StatefulWidget {
  const addSet({Key? key}) : super(key: key);

  @override
  _addSet createState() => _addSet();
}

class _addSet extends State<addSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Scaffold(
        body: SizedBox(
          height: 75,
          width: 500,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 30,
                    width: 75,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          labelText: 'Sets',
                          labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 75,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          labelText: 'Reps',
                          labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 75,
                    child: TextFormField(
                        enableInteractiveSelection: false,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            labelText: 'Weight',
                            labelStyle: TextStyle(fontSize: 15))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
