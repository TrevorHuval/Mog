import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/utils.dart';
import '/models/user.dart';

class UserService {
  UtilsService _utilsService = UtilsService();
  final String uid;
  UserService({required this.uid});

  List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        id: doc.id,
        username: (doc.data() as dynamic)['username'] ?? '',
        firstName: (doc.data() as dynamic)['firstName'] ?? '',
        lastName: (doc.data() as dynamic)['lastName'] ?? '',
        profileImageUrl: (doc.data() as dynamic)['profileImageUrl'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        sex: (doc.data() as dynamic)['sex'] ?? '',
        weight: (doc.data() as dynamic)['weight'] ?? '',
        inches: (doc.data() as dynamic)['inches'] ?? '',
        feet: (doc.data() as dynamic)['feet'] ?? '',
        benchPR: (doc.data() as dynamic)['benchPR'] ?? 0,
        squatPR: (doc.data() as dynamic)['squatPR'] ?? 0,
        deadliftPR: (doc.data() as dynamic)['deadliftPR'] ?? 0,
        inGroup: (doc.data() as dynamic)['inGroup'] ?? false,
        streak: (doc.data() as dynamic)['streak'] ?? 0,
      );
    }).toList();
  }

  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      return UserModel(
        id: snapshot.id,
        username: (snapshot.data() as dynamic)['username'] ?? '',
        firstName: (snapshot.data() as dynamic)['firstName'] ?? '',
        lastName: (snapshot.data() as dynamic)['lastName'] ?? '',
        profileImageUrl: (snapshot.data() as dynamic)['profileImageUrl'] ?? '',
        email: (snapshot.data() as dynamic)['email'] ?? '',
        sex: (snapshot.data() as dynamic)['sex'] ?? '',
        weight: (snapshot.data() as dynamic)['weight'] ?? '',
        inches: (snapshot.data() as dynamic)['inches'] ?? '',
        feet: (snapshot.data() as dynamic)['feet'] ?? '',
        benchPR: (snapshot.data() as dynamic)['benchPR'] ?? 0,
        squatPR: (snapshot.data() as dynamic)['squatPR'] ?? 0,
        deadliftPR: (snapshot.data() as dynamic)['deadliftPR'] ?? 0,
        inGroup: (snapshot.data() as dynamic)['inGroup'] ?? false,
        streak: (snapshot.data() as dynamic)['streak'] ?? 0,
      );
    } else {
      return null;
    }
  }

  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Stream<List<UserModel>> queryByUsername(search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("username")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Future<void> sendFriendRequest(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sentFriendRequests')
        .doc(uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friendRequests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});
  }

  Stream<bool> hasSentFriendRequest(uid, otherId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("sentFriendRequests")
        .doc(otherId)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<void> declineFriendRequest(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sentFriendRequests')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friendRequests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future<void> acceptFriendRequest(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('friends')
        .doc(uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sentFriendRequests')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friendRequests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future<void> removeFriend(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('friends')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future<void> updateUserProfileImage(uid, profileImageUrl) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'profileImageUrl': profileImageUrl}, SetOptions(merge: true));
  }
}
