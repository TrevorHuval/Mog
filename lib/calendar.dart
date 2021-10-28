// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

//import 'utils.dart';

class Calendar extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? _selectedDay;

  OnDaySelected(date, events, e) {
    setState(() {
      focusedDay = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TableCalendar(
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          focusedDay: focusedDay,
          firstDay: DateTime(DateTime.now().year, DateTime.now().month - 12,
              DateTime.now().day),
          lastDay: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
              selectedDecoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: Colors.red.shade200, shape: BoxShape.circle)),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                focusedDay = focusedDay;
              });
            }
          },
          onPageChanged: (focusedDay) {
            focusedDay = focusedDay;
          },
          calendarFormat: _calendarFormat,
        ),
      ),
    );
  }
}
