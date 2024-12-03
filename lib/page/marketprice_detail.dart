import 'package:flutter/material.dart';
import 'package:taniku/page/tutorial_detail.dart';

class MarketPriceDetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const MarketPriceDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

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
      body: Stack(children: [
        // Dekorasi lingkaran
        _buildDecorativeCircles(),

        // Konten utama
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bagian "Informasi Harga Buah"
                const Text(
                  "Informasi Harga Buah",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Card utama
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xF5F5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            imagePath,
                            height: 123,
                            width: 170,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff00813E),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Pajak Singa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // Harga dari pajak lain
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff00813E),
                        // Warna hijau
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Harga dari pajak lain",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // Daftar pajak lain
                _buildPajakCard("Pajak Berastagi", "Rp 8.500"),
                _buildPajakCard("Pajak Roga", "Rp 8.000"),
                _buildPajakCard("Pajak Buah", "Rp 8.000"),
                const SizedBox(height: 16),
                // Tombol "Tampilkan semua"
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Tampilkan semua",
                      style: TextStyle(
                        color: Color(0xff00813E),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Bagian tutorial
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff00813E),
                        // Warna hijau
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Tutorial",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildSmallCard(
                  context,
                  "Tutorial Title",
                  "Publisher Name",
                  "1000 views",
                ),
                _buildSmallCard(
                  context,
                  "Tutorial Title",
                  "Publisher Name",
                  "1000 views",
                ),
                _buildSmallCard(
                  context,
                  "Tutorial Title",
                  "Publisher Name",
                  "1000 views",
                ),
              ],
            ),
          ),
        ),
        _buildDecorativeCircles(),
      ]),
    );
  }

  // Widget untuk menampilkan informasi pajak lain
  Widget _buildPajakCard(String title, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Jl Jamin Ginting, Berastagi, Sumatera Utara, 2045",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff00813E),
              ),
            ),
          ],
        ),
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

  // Widget untuk menampilkan tutorial
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "asset/img/post.png",
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("asset/img/profil.jpg"),
                          radius: 12,
                        ),
                        const SizedBox(width: 8),
                        Text(publisher),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      views,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
