import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '/models/user.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return UserModel(id: user.uid, profileImageUrl: "");
    } else {
      return null;
    }
  }

  Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  assignProfileImage() async {}

  Future signUp(username, firstName, lastName, email, password, sex, weight,
      feet, inches) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'sex': sex,
        'weight': weight,
        'feet': feet,
        'inches': inches,
        'inGroup': false,
        'benchPR': 0,
        'squatPR': 0,
        'deadliftPR': 0,
        'streak': 0,
      });
      String profileImageDownloadUrl =
          "https://firebasestorage.googleapis.com/v0/b/mogdb-f5659.appspot.com/o/defaultUserProfileImage.jpg?alt=media&token=119e1aa6-c914-4a51-8ee0-32af4da2a45c";

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({'profileImageUrl': profileImageDownloadUrl},
              SetOptions(merge: true));
      _userFromFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)) as User;

      _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}
