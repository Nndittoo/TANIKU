import 'package:flutter/material.dart';
import 'package:taniku/page/tutorial_detail.dart';
import 'package:taniku/models/marketprice_model.dart';
import 'package:taniku/api/api_taniku.dart';

class MarketPriceDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String imagePath;

  const MarketPriceDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  State<MarketPriceDetailPage> createState() => _MarketPriceDetailPageState();
}

class _MarketPriceDetailPageState extends State<MarketPriceDetailPage> {
  bool showAllPajak = false;

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
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
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bagian "Informasi Harga Buah"
                const Text(
                  "Informasi Harga Buah",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // Card utama
                FutureBuilder<List<MarketPrice>>(
                  future: apiService.getMarket(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No market prices found'));
                    } else {
                      final marketPrices = snapshot.data!;
                      final marketPrice =
                          marketPrices.firstWhere((mp) => mp.id == widget.id);
                      final kilosToShow = showAllPajak
                          ? marketPrice.kilos
                          : marketPrice.kilos.take(3).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card utama
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xF5F5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      widget.imagePath,
                                      height: 123,
                                      width: 170,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.name,
                                          style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Monsterrat',
                                          ),
                                        ),
                                        Text(
                                          marketPrice.kilos.isNotEmpty
                                              ? 'Rp ${marketPrice.kilos[0].hp}/kg'
                                              : 'Unavailable',
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Monsterrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -20, // Kotak hijau naik keluar
                                right: -20,
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
                                  child: Row(
                                    children: [
                                      Text(
                                        marketPrice.kilos.isNotEmpty
                                            ? marketPrice.kilos[0].pajak.pajak
                                            : 'Unavailable',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Monsterrat',
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.location_on,
                                          color: Colors.white, size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
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
                                    color: Colors.white,
                                    fontFamily: 'Monsterrat',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (marketPrice.kilos.length > 1)
                            ...kilosToShow.skip(1).map((kilo) {
                              return _buildPajakCard(
                                kilo.hp,
                                kilo.pajak.pajak,
                                kilo.pajak.alamat,
                              );
                            })
                          else
                            const Text(
                              "Harga dari pajak lain tidak tersedia",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          if (marketPrice.kilos.length > 3)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showAllPajak = !showAllPajak;
                                });
                              },
                              child: Text(showAllPajak
                                  ? 'Tampilkan lebih sedikit'
                                  : 'Tampilkan semua'),
                            ),
                        ],
                      );
                    }
                  },
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
                          color: Colors.white,
                          fontFamily: 'Monsterrat',
                        ),
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
  Widget _buildPajakCard(String price, String pajak, String alamat) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pajak,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Monsterrat',
                    ),
                  ),
                  Text(
                    alamat,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Monsterrat',
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Text(
              'Rp $price',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff00813E),
                fontFamily: 'Monsterrat',
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
      // onTap: () {
      //   // Navigasi ke TutorialDetailPage
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => TutorialDetailPage(
      //         title: title,
      //         publisher: publisher,
      //       ),
      //     ),
      //   );
      // },
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
                        fontFamily: 'Monsterrat',
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
