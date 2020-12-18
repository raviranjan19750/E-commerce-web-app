// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/models/user.dart';

class AnonymousSignIn {
  // User _createAnonymousUser(User user) {
  //   return user != null ? User : null;
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign in anonymously
  Future<User> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      print(result.user.metadata.toString() + "reached here");
      return user;
    } catch (e) {
      print("Error @ sign in anonymously : ${e.toString()}");
      return null;
    }
  }
}

// where to call -> main.Dart
// persistance
// createuser
// signinwithcustom token
