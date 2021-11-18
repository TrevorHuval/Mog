// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firstapp/models/user.dart';

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
      //'members': [],
      //'messages': ,
      'groupId': '',
    });
    userCollection.doc(uid).set({'inGroup': true}, SetOptions(merge: true));

    await groupDocRef.update({
      //'members': FieldValue.arrayUnion([uid]),
      'groupId': groupDocRef.id
    });

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
    //return FirebaseFirestore.instance.collection('groups').id;
  }

  Stream<List<DocumentSnapshot>> getUserGroupsStream(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get() as Stream<List<DocumentSnapshot>>;
  }

  Future<List<DocumentSnapshot>> getGroups3() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .document('uid')
        .collection('groups')
        .get();
    final groupData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<DocumentSnapshot> documentList = groupData;
  }
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
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
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);

final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
