import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/models/user.dart';

class AnonymousSignIn {
  UserDetails _createAnonymousUser(User user) {
    return user != null ? UserDetails(uid: user.uid) : null;
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _createAnonymousUser(user);
    } catch (e) {
      print("Error @ sign in anonymously : ${e.toString()}");
    }
  }
}
