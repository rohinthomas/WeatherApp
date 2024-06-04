import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard {
  static Future<bool> isAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
