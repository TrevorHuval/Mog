import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
}
