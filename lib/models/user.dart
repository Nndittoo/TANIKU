import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid; // ID unik pengguna
  final String? email; // Email pengguna (jika tersedia)
  final String? displayName; // Nama tampilan pengguna (jika tersedia)
  final String? photoURL; // URL foto profil pengguna (jika tersedia)
  final String?
      providerId; // Metode login yang digunakan (Google, Facebook, Email, dll)

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.providerId,
  });

  // Membuat model dari Firebase User
  factory AppUser.fromFirebase(User user) {
    // Mendapatkan providerId dari metode login
    final providerData =
        user.providerData.isNotEmpty ? user.providerData[0] : null;

    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      providerId: providerData
          ?.providerId, // Contoh: 'google.com', 'facebook.com', 'password'
    );
  }
}
