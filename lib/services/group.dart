import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/models/group.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/utils.dart';

class GroupService {
  UtilsService _utilsService = UtilsService();
  final String groupid;
  GroupService({required this.groupid});

  GroupModel? _groupFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      return GroupModel(
        id: snapshot.id,
        groupImageUrl: (snapshot.data() as dynamic)['groupImageUrl'] ?? '',
        groupName: (snapshot.data() as dynamic)['groupName'] ?? '',
        memberCount: (snapshot.data() as dynamic)['memberCount'] ?? 0,
      );
    } else {
      return null;
    }
  }

  String getGroupId(groupid) {
    DocumentReference groupRef = FirebaseFirestore.instance
        .collection("users")
        .doc(groupid)
        .collection("groups")
        .doc();

    return groupRef.id;
  }

  Future<int> getMemberCount() async {
    final QuerySnapshot<Map<String, dynamic>> userGroups =
        await FirebaseFirestore.instance
            .collection('groups')
            .doc(groupid)
            .collection('members')
            .get();
    List<DocumentSnapshot> members = userGroups.docs;
    return members.length;
  }

  Future<List<DocumentSnapshot>> getGroupMemberIDs() async {
    final QuerySnapshot<Map<String, dynamic>> groupMembers =
        await FirebaseFirestore.instance
            .collection('groups')
            .doc(groupid)
            .collection('members')
            .get();
    List<DocumentSnapshot> documents = groupMembers.docs;
    return documents;
  }

  Stream<GroupModel?> getGroupInfo(groupid) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupid)
        .snapshots()
        .map(_groupFromFirebaseSnapshot);
  }

  Future<void> updateGroupProfileImage(gruopid, groupImageUrl) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupid)
        .set({'groupImageUrl': groupImageUrl}, SetOptions(merge: true));
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
