import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/utils.dart';
import '/models/user.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        id: doc.id,
        firstName: (doc.data() as dynamic)['firstName'] ?? '',
        lastName: (doc.data() as dynamic)['lastName'] ?? '',
        //profileImageUrl: (doc.data() as dynamic)['profileImageUrl'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        sex: (doc.data() as dynamic)['sex'] ?? '',
        weight: (doc.data() as dynamic)['weight'] ?? '',
        inches: (doc.data() as dynamic)['inches'] ?? '',
        feet: (doc.data() as dynamic)['feet'] ?? '',
      );
    }).toList();
  }

  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      return UserModel(
        id: snapshot.id,
        firstName: (snapshot.data() as dynamic)['firstName'] ?? '',
        lastName: (snapshot.data() as dynamic)['lastName'] ?? '',
        //profileImageUrl: (doc.data() as dynamic)['profileImageUrl'] ?? '',
        email: (snapshot.data() as dynamic)['email'] ?? '',
        sex: (snapshot.data() as dynamic)['sex'] ?? '',
        weight: (snapshot.data() as dynamic)['weight'] ?? '',
        inches: (snapshot.data() as dynamic)['inches'] ?? '',
        feet: (snapshot.data() as dynamic)['feet'] ?? '',
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

  Stream<List<UserModel>> queryByName(search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }
}
