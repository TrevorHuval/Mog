import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/models/group.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/utils.dart';
import '/models/user.dart';

class GroupService {
  UtilsService _utilsService = UtilsService();
  final String uid;
  GroupService({required this.uid});

  GroupModel? _groupFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      return GroupModel(
          id: snapshot.id,
          admin: (snapshot.data() as dynamic)['admin'] ?? '',
          groupImageUrl: (snapshot.data() as dynamic)['groupImageUrl'] ?? '',
          groupName: (snapshot.data() as dynamic)['groupName'] ?? '');
    } else {
      return null;
    }
  }

  String getGroupId(uid) {
    DocumentReference groupRef = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("groups")
        .doc();

    return groupRef.id;
  }

  Stream<GroupModel?> getGroupInfo(uid) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(uid)
        .snapshots()
        .map(_groupFromFirebaseSnapshot);
  }

  /*Stream<List<GroupModel>> queryByName(search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }*/

}
