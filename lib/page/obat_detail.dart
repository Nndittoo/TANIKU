import 'package:flutter/material.dart';
import 'package:taniku/page/tutorial_detail.dart';

class ObatDetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const ObatDetailPage(
      {super.key,
      required this.name,
      required this.price,
      required this.imagePath});

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Kembali
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                      size: 24,
                    ),
                    label: const Text(
                      "Kembali",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bagian "Informasi Harga Buah"
              const Text(
                "Informasi Obat",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Image.asset(
                imagePath,
              ),

              const SizedBox(height: 10),
              // Harga dari pajak lain
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff00813E)),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                      "Roundup digunakan dengan tujuan utama untuk mengendalikan gulma dan tanaman yang tidak diinginkan dalam pertanian dan lanskap. ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fungsi $name",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff00813E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 160,
                    // Tinggi card
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCard("Mengendalikan Gulma", imagePath),
                        _buildCard("Pemeliharaan Kebun", imagePath),
                        _buildCard("Pengendalian Tanaman", imagePath),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cara menggunakan $name",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00813E),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(height: 3),
                  _buildSmallCard(
                    context,
                    "Menggunakan Roundup",
                    "Admin Taniku",
                    "1000 views",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(String title, String imagePath) {
  return Card(
      color: Colors.white, // Membuat card transparan
      child: SizedBox(
        width: 138,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                imagePath, // Gambar sesuai parameter
                width: 138,
                height: 109,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                title, // Judul sesuai parameter
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ));
}

Widget _buildSmallCard(
  BuildContext context,
  String title,
  String publisher,
  String views,
) {
  return InkWell(
    onTap: () {
      // Navigasi ke TutorialDetailPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorialDetailPage(
            title: title,
            publisher: publisher,
          ),
        ),
      );
    },
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('asset/img/post.png',
                  width: 129, height: 116, fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff00813E),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('asset/img/profil.jpg'),
                        radius: 28,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            publisher,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            views,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '4jam yg lalu',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
