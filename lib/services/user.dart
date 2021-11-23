import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/set.dart';
import 'package:firstapp/services/utils.dart';
import 'package:flutter/cupertino.dart';
import '/models/user.dart';

class UserService extends ChangeNotifier {
  UtilsService _utilsService = UtilsService();
  final String uid;
  UserService({required this.uid});
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  late UserModel _currentUser;
  UserModel get currentUser => _currentUser;

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

  void init(String uid) async {
    usersCollection.doc(uid).snapshots().listen((event) {
      _currentUser = UserModel.fromMap(event.data()!);
      notifyListeners();
    });
  }

  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<List<DocumentSnapshot>> queryByUsername(search) async {
    final QuerySnapshot<Map<String, dynamic>> list = await FirebaseFirestore
        .instance
        .collection('users')
        .where('username'.toLowerCase(), isGreaterThanOrEqualTo: search)
        .where('username'.toLowerCase(), isLessThanOrEqualTo: search + "\uF7FF")
        .get();
    List<DocumentSnapshot> documentsOfUsers = list.docs;
    return documentsOfUsers;
  }

  Future<List<DocumentSnapshot>> getUserFriends() async {
    final QuerySnapshot<Map<String, dynamic>> userFriends =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('friends')
            .get();
    List<DocumentSnapshot> documents = userFriends.docs;
    return documents;
  }

  Future<void> sendFriendRequest(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("sentFriendRequests")
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
        .doc(uid)
        .collection('sentFriendRequests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    print("get the fuck");

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('friendRequests')
        .doc(uid)
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
        .doc(uid)
        .collection('sentFriendRequests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('friendRequests')
        .doc(uid)
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

    notifyListeners();
  }

  Future<void> updateUserProfileImage(uid, profileImageUrl) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'profileImageUrl': profileImageUrl}, SetOptions(merge: true));
  }

  Future<int> getNumFriendRequests() async {
    final QuerySnapshot<Map<String, dynamic>> friendRequests =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('friendRequests')
            .get();
    List<DocumentSnapshot> requests = friendRequests.docs;
    return requests.length;
  }

  Future<List<DocumentSnapshot>> getFriendRequests() async {
    final QuerySnapshot<Map<String, dynamic>> friendRequests =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('friendRequests')
            .get();
    List<DocumentSnapshot> documents = friendRequests.docs;
    return documents;
  }

  Future<bool> isFriend(friendid) async {
    late bool exists;
    var collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(friendid)
        .collection("friends");

    await collectionRef.doc(uid).get().then((doc) {
      exists = doc.exists;
    });
    return exists;
  }

  Future<void> addExercise(
      date, exerciseType, numOfSets, numOfReps, weight) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pastWorkouts')
        .doc(date)
        .collection(exerciseType)
        .doc()
        .set(
            {'numOfSets': numOfSets, 'numOfReps': numOfReps, 'weight': weight});
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
}
