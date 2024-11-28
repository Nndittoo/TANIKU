import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get user => _auth.currentUser!;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    try {
      // Logika login Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      log("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      // Membuat akun baru
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Memperbarui profil pengguna untuk menambahkan nama
      if (cred.user != null) {
        await cred.user!.updateDisplayName(name);
        await cred.user!
            .reload(); // Memuat ulang data pengguna untuk mendapatkan nama yang diperbarui
      }
      return _auth.currentUser; // Mengembalikan user yang telah diperbarui
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ("Email sudah digunakan");
        }
        if (e.code == 'weak-password') {
          ("Password terlalu lemah");
        }
        if (e.code == 'invalid-email') {
          ("Email tidak valid");
        }
      } else {
        log("Error during registration: $e");
      }
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Eror during login: $e ");
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
  }
}
