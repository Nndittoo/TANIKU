import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        await cred.user!.reload(); // Memuat ulang data pengguna
      }
      return _auth.currentUser; // Mengembalikan user yang telah diperbarui
    } on FirebaseAuthException catch (e) {
      // Tangkap kode error FirebaseAuthException
      switch (e.code) {
        case 'email-already-in-use':
          log("Email sudah digunakan");
          throw Exception("Email sudah digunakan. Gunakan email lain.");
        case 'weak-password':
          log("Password terlalu lemah");
          throw Exception(
              "Password terlalu lemah. Gunakan password yang lebih kuat.");
        case 'invalid-email':
          log("Email tidak valid");
          throw Exception("Format email tidak valid.");
        default:
          log("Error: ${e.code}");
          throw Exception("Terjadi kesalahan, coba lagi.");
      }
    } catch (e) {
      // Tangkap error lain
      log("Error during registration: $e");
      throw Exception("Terjadi kesalahan tidak terduga.");
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      // Tangkap kode error FirebaseAuthException
      switch (e.code) {
        case 'user-not-found':
          log("Email tidak ditemukan");
          throw Exception(
              "Email tidak ditemukan. Silakan daftar terlebih dahulu.");
        case 'wrong-password':
          log("Password salah");
          throw Exception("Password salah. Silakan coba lagi.");
        case 'invalid-email':
          log("Email tidak valid");
          throw Exception("Format email tidak valid.");
        default:
          log("Error: ${e.code}");
          throw Exception("Terjadi kesalahan, coba lagi.");
      }
    } catch (e) {
      // Tangkap error lain
      log("Error during registration: $e");
      throw Exception("Terjadi kesalahan tidak terduga.");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
