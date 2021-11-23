import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/widgets/graph.dart';
import 'package:table_calendar/table_calendar.dart';

class Progress extends StatefulWidget {
  @override
  _Progress createState() => _Progress();
}

class _Progress extends State<Progress> {
  var selectedDateMessage = "Select a date";
  String graphType = "Weight";
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>>? _exercises;

  void _setGraphType(String selectedGraphType) {
    Navigator.pop(context);
    setState(() {
      graphType = selectedGraphType;
    });
  }

  @override
  void initState() {
    _exercises = {};

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: <Widget>[
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      color: Colors.transparent,
                      height: 400,
                      width: 500,
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TableCalendar(
                          headerStyle: const HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                          ),
                          focusedDay: _focusedDay,
                          firstDay: DateTime(DateTime.now().year,
                              DateTime.now().month - 12, DateTime.now().day),
                          lastDay: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            selectedDecoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            todayDecoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(
                                () {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                },
                              );
                            }
                          },
                          onPageChanged: (focusedDay) {
                            focusedDay = focusedDay;
                          },
                          calendarFormat: _calendarFormat,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "Select a date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: const Text(
                              "Edit Workout",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Card(
                        color: Colors.grey.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0,
                            color: Colors.grey.shade100,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: const <Widget>[
                              Text("Please select a date to view its workout",
                                  style: TextStyle(color: Colors.grey))
                            ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      color: Colors.transparent,
                      width: 500,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ListTile(
                                              title: const Text('Weight'),
                                              onTap: () =>
                                                  _setGraphType('Weight')),
                                          ListTile(
                                              title: const Text('Bench Press'),
                                              onTap: () =>
                                                  _setGraphType('Bench Press')),
                                          ListTile(
                                              title: const Text(
                                                  'Tricep Extension'),
                                              onTap: () => _setGraphType(
                                                  'Tricep Extension')),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(graphType,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                  Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.grey.shade700,
                                  )
                                ],
                              ),
                            ),
                            const Graph(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
