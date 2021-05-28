import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/models/users.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(userID: user.uid) : null;
  }

  Future login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

// *****************************
//get current user
// getCurrentUser() async {
//   return _auth.currentUser;
// }

// registration with email and password
// Future createNewUser(String name, String email, String password) async {
//   try {
//     AuthResult result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     FirebaseUser user = result.user;
//     await DatabaseManager()
//         .createUserData(name, true, 'assets/images/namjoon.jpg', user.uid);
//     return user;
//   } catch (e) {
//     print(e.toString());
//   }
// }

// sign with email and password
// Future loginUser(String email, String password) async {
//   try {
//     AuthResult result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);

//     return result.user;
//   } catch (e) {
//     print(e.toString());
//   }
// }

// signout
