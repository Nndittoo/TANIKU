import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/page/auth/login.dart';
import 'package:pemrograman_mobile/page/home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol Kembali
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    Text(
                      "Kembali",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Foto Profil dengan Icon Edit
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("asset/img/profil.jpg"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xff00813E),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () {
                              // Fungsi untuk edit foto profil
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Tombol-tombol di bawah Foto Profil
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildIconButton(Icons.add, "Posting", const Color(0xff00813E), () {
                      // Fungsi untuk tombol Posting
                      print("Posting button pressed");
                    }),
                    _buildIconButton(Icons.attach_money, "Harga", const Color(0xff00813E), () {
                      // Fungsi untuk tombol Harga
                      print("Harga button pressed");
                    }),
                    _buildIconButton(Icons.video_call, "Tutorial", const Color(0xff00813E), () {
                      // Fungsi untuk tombol Tutorial
                      print("Tutorial button pressed");
                    }),
                    _buildIconButton(Icons.cloud, "Cuaca", const Color(0xff00813E), () {
                      // Fungsi untuk tombol Cuaca
                      print("Cuaca button pressed");
                    }),
                    _buildIconButton(Icons.water_drop, "Obat", const Color(0xff00813E), () {
                      // Fungsi untuk tombol Obat
                      print("Obat button pressed");
                    }),
                  ],
                ),
                SizedBox(height: 20),
                // Daftar Tombol
                _buildListButton(Icons.edit, "Edit Profil", context, () {
                  // Fungsi untuk tombol Edit Profil
                  print("Edit Profil button pressed");
                }),
                _buildListButton(Icons.search, "Cari Di Taniku", context, () {
                  // Fungsi untuk tombol Cari Di Taniku
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                }),
                _buildListButton(Icons.settings, "Pengaturan", context, () {
                  // Fungsi untuk tombol Pengaturan
                  print("Pengaturan button pressed");
                }),
                _buildListButton(Icons.logout, "Keluar", context, () {
                  // Fungsi untuk tombol Keluar
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                }),
              ],
            ),
          ),
          // Bola Dekorasi di Sudut Atas Kanan dan Bawah Kiri
          Positioned(
            top: -10,
            right: -5,
            child: Image.asset("asset/img/bola-tipis-atas.png"),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Image.asset("asset/img/bola-tipis-bawah.png"),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat tombol ikon dengan latar belakang
  Widget _buildIconButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat tombol daftar
  Widget _buildListButton(IconData icon, String label, BuildContext context, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff00813E)),
        title: Text(label),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onPressed,
      ),
    );
  }
}
