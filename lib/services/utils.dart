import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firstapp/models/set.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class UtilsService {
  Future<String> uploadFile(File _image, String path) async {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);
    String returnURL = '';
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }
}

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future createGroup(String groupName) async {
    DocumentReference groupDocRef = await groupCollection.add({
      'groupName': groupName,
      'groupImage':
          'https://firebasestorage.googleapis.com/v0/b/mogdb-f5659.appspot.com/o/defaultGroupProfileImage.jpg?alt=media&token=ecf67ead-6d9f-46d3-9256-2c3f214f258a',
      'admin': uid,
      'groupId': '',
    });
    userCollection.doc(uid).set({'inGroup': true}, SetOptions(merge: true));

    await groupDocRef.update({'groupId': groupDocRef.id});

    await groupDocRef.collection('members').doc(uid).set({});

    DocumentReference userDocRef = userCollection.doc(uid);
    await userDocRef.collection('groups').doc(groupDocRef.id).set({});
  }

  Future<List<DocumentSnapshot>> getUserGroups() async {
    final QuerySnapshot<Map<String, dynamic>> userGroups =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('groups')
            .get();
    List<DocumentSnapshot> documents = userGroups.docs;
    return documents;
  }

  SetModel? _setFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      return SetModel(
          id: snapshot.id,
          numOfSets: (snapshot.data() as dynamic)['numOfSets'] ?? 0,
          numOfReps: (snapshot.data() as dynamic)['numOfReps'] ?? 0,
          weight: (snapshot.data() as dynamic)['weight'] ?? 0);
    } else {
      return null;
    }
  }

  String stringOfSet(SetModel setModel) {
    String returnStr =
        "${setModel.numOfSets} sets of ${setModel.numOfReps} reps for ${setModel.weight}";
    return returnStr;
  }

  Future<void> buildEventFromDatabase(String date) async {
    List<DocumentSnapshot> exerciseTypes = await getExerciseTypes(date);
    String dateDay = date.replaceAll("_", "/");
    DateTime dtDate = new DateFormat('MM/dd/yyyy').parse(dateDay);
    if (kEvents[dtDate]!.isNotEmpty) {
      kEvents[dtDate] = [];
    }

    exerciseTypes.forEach((DocumentSnapshot exercise) async {
      await getWorkoutSets(date, exercise.id);
    });
  }

  Future<List<DocumentSnapshot>> getExerciseTypes(String date) async {
    final QuerySnapshot<Map<String, dynamic>> workouts = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('pastWorkouts')
        .doc(date)
        .collection('workouts')
        .get();
    List<DocumentSnapshot> documents = workouts.docs;
    //print(documents[0].id);
    return documents;
  }

  Future<void> getWorkoutSets(String date, String exerciseType) async {
    String exerciseSetList = "";
    final QuerySnapshot<Map<String, dynamic>> workouts = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('pastWorkouts')
        .doc(date)
        .collection("workouts")
        .doc(exerciseType)
        .collection(exerciseType)
        .get();
    List<DocumentSnapshot> documents = workouts.docs;
    String dateDay = date.replaceAll("_", "/");
    DateTime dtDate = new DateFormat('MM/dd/yyyy').parse(dateDay);
    documents.forEach((element) {
      SetModel? thisSet = _setFromFirebaseSnapshot(element);
      exerciseSetList = exerciseSetList +
          "${thisSet!.numOfSets} sets of ${thisSet.numOfReps} reps for ${thisSet.weight} \n";
    });
    if (kEvents[dtDate] != null) {
      kEvents[dtDate]!.add(Event(exerciseType, exerciseSetList));
    } else {
      kEvents[dtDate] = [Event(exerciseType, exerciseSetList)];
    }
  }
}

class Event {
  final String exerciseType;
  final String sets;

  const Event(this.exerciseType, this.sets);
}

String createRandomEvents() {
  Random random = new Random();
  return getRandomExercise();
}

String getRandomExercise() {
  Random random = new Random();
  int randomExercise = random.nextInt(9);
  switch (randomExercise) {
    case 0:
      {
        return "Bench Press";
      }
    case 1:
      {
        return "Deadlift";
      }
    case 2:
      {
        return "Squat";
      }
    case 3:
      {
        return "Lat Pulldown";
      }
    case 4:
      {
        return "Tricep Extensions";
      }
    case 5:
      {
        return "Leg Press";
      }
    case 6:
      {
        return "Preacher Curl";
      }
    case 7:
      {
        return "Cable Fly";
      }
    case 8:
      {
        return "Skull Crushers";
      }
  }
  return "";
}

String getRandomSets() {
  Random randomWeight = Random();
  Random randomReps = Random();
  Random randomSets = Random();

  double randomWeightNum =
      ((45 + randomWeight.nextInt(200 - 45)) / 5).floorToDouble() * 5;
  int randomRepsNum = (5 + randomReps.nextInt(15 - 5));
  int randomSetsNum = (3 + randomSets.nextInt(12 - 3));

  return "$randomSetsNum sets of $randomRepsNum reps for $randomWeightNum \n${randomSetsNum - 1} sets of ${randomRepsNum + 1} reps for ${randomWeightNum + 5} \n${randomSetsNum - 2} sets of ${randomRepsNum + 2} reps for ${randomWeightNum + 10}";
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(90, (index) => index),
    key: (item) => DateTime.utc(kToday.year, kFirstDay.month, item * 1),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event(getRandomExercise(), getRandomSets())))
  ..addAll({
    kToday: [],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 1, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 1, kToday.day);
