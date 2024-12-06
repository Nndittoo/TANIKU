import 'package:flutter/material.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40), // Tinggi AppBar
        child: Container(
          color: Colors.transparent, // Warna AppBar putih
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment
                  .bottomCenter, // Menjaga posisi kontainer tetap berada di tengah AppBar
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  color: const Color(0xff00813E), // Warna hijau
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Kembali
                    IconButton(
                      icon: Image.asset(
                        'asset/img/arrow.png', // Path ke gambar arrow
                        width: 30, // Menyesuaikan ukuran gambar
                        height: 30, // Menyesuaikan ukuran gambar
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Teks "Notifikasi" di tengah
                    const Text(
                      "Notifikasi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    // Tombol Hapus
                    IconButton(
                      icon: Image.asset(
                        'asset/img/hapus.png', // Path ke gambar arrow
                        width: 30, // Menyesuaikan ukuran gambar
                        height: 30, // Menyesuaikan ukuran gambar
                      ),
                      onPressed: () {
                        // Aksi tombol hapus
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text("Halaman Notifikasi"),
          ),
          _buildDecorativeCircles(),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        Positioned(
            top: -10,
            right: -5,
            child: Image.asset("asset/img/bola-tipis-atas.png")),
        Positioned(
            bottom: -40,
            left: -40,
            child: Image.asset("asset/img/bola-tipis-bawah.png")),
      ],
    );
  }
}
