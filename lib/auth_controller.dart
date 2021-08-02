import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<User> signInAnonymous() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> register(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<User> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<void> logout() async {
    firebaseAuth.signOut();
  }

  static Stream<User> get userStream => firebaseAuth.authStateChanges();
}
