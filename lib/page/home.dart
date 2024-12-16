import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taniku/api/weather_service.dart';
import 'package:intl/intl.dart';
import 'package:taniku/helper/utils.dart';
import 'package:taniku/page/marketprice_detail.dart';
import 'package:taniku/page/notifikasi.dart';
import 'package:taniku/page/obat_detail.dart';
import 'package:taniku/page/profil.dart';
import 'package:taniku/page/auth/auth_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taniku/page/tutorial_detail.dart';
import 'package:taniku/models/tutorial_model.dart';
import 'package:taniku/models/obat_model.dart';
import 'package:taniku/models/marketprice_model.dart';
import 'package:taniku/api/api_taniku.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Indeks halaman aktif
  final PageController _pageController =
      PageController(); // Controller untuk PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("asset/img/logo-daun.png"),
        ),
        title: const Text(
          "Taniku",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontFamily: "Righteous",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotifikasiPage()));
            },
            icon: const Icon(Icons.mark_email_unread_outlined),
            color: Colors.black87,
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: CircleAvatar(
              backgroundImage: AuthService().user.photoURL != null &&
                      AuthService().user.photoURL!.isNotEmpty
                  ? NetworkImage(AuthService().user.photoURL!)
                  : const AssetImage("asset/img/profile_default.png")
                      as ImageProvider,
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          buildMainContent(context), // Halaman utama
          const MarketPricePage(), // Halaman kedua
          const TutorialPage(), // Halaman ketiga
          const ObatPage(), // Halaman keempat
          const CuacaPage(), // Halaman kelima
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'btnPost',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPostPage()));
              }, // Aksi untuk tambah postingan
              backgroundColor: const Color(0xff00813E),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'btnSearch',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              }, // Aksi untuk pencarian
              backgroundColor: const Color(0xff00813E),
              mini: true,
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex, // Setel indeks aktif
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index); // Berpindah halaman
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Harga'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_call), label: 'Tutorial'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Obat'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
        ],
      ),
    );
  }

  final WeatherService _weatherService = WeatherService();
  final ApiService apiService = ApiService();
  late double lat;
  late double lon;

  // Fungsi untuk mendapatkan lokasi dan cuaca
  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      Position position = await _weatherService.getCurrentPosition();
      lat = position.latitude;
      lon = position.longitude;

      final currentData =
          await _weatherService.fetchWeatherDataByLocation(lat, lon);
      return {
        'current': currentData,
      };
    } catch (e) {
      throw Exception('Gagal mendapatkan data cuaca: $e');
    }
  }

  Widget buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Widget untuk menampilkan data cuaca
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/img/bg-cuaca.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchWeather(), // Memanggil fetchWeather
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Tampilkan loading
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Gagal Memuat Data')); // Tampilkan error jika ada
                  } else if (snapshot.hasData) {
                    var currentWeatherData = snapshot.data!['current'];
                    String cityName =
                        currentWeatherData['name']; // Ambil nama kota dari data

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cityName,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${currentWeatherData!['main']['temp'].toInt()}°C',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                Text(
                                  '${currentWeatherData['weather'][0]['description']}',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _currentIndex =
                                          4; // Indeks halaman 'CuacaPage'
                                      _pageController.jumpToPage(
                                          4); // Navigasi ke halaman 'CuacaPage'
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "More info",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  getWeatherImage(
                                    currentWeatherData['weather'][0]['main'],
                                  ),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('Data tidak tersedia'));
                  }
                },
              ),
            ),

            //akhir dari widget cuaca
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Harga Pasar",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Righteous',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1; // Indeks halaman 'MarketPricePage'
                      _pageController.jumpToPage(
                          1); // Navigasi ke halaman 'MarketPricePage'
                    });
                  },
                  child: const Text(
                    "Selengkapnya >",
                    style: TextStyle(
                      color: Color(0xff00813E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<MarketPrice>>(
              future: apiService.getMarket(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No market prices found'));
                } else {
                  final marketPrices = snapshot.data!;
                  return SizedBox(
                    height: 145,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: marketPrices.length,
                      itemBuilder: (context, index) {
                        final marketPrice = marketPrices[index];
                        return FruitCardH(
                          id: marketPrice.id,
                          name: marketPrice.namaBuah,
                          imagePath: marketPrice.potoBuah,
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tutorial Bertani",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Righteous',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                      _pageController.jumpToPage(2);
                    });
                  },
                  child: const Text(
                    "Selengkapnya >",
                    style: TextStyle(
                      color: Color(0xff00813E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Tutorial>>(
              future: apiService.getTutorials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Gagal Memuat Data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tutorial Tidak Ditemukan'));
                } else {
                  final tutorials = snapshot.data!;
                  final latestTutorials = tutorials
                      .take(2)
                      .toList(); // Mengambil dua tutorial terbaru
                  return Column(
                    children: latestTutorials.map((tutorial) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TutorialDetailPage(
                                title: tutorial.judul,
                                publisher: tutorial.creator,
                                description: tutorial.deskripsi,
                                imageUrl: tutorial.photoCreator,
                                videoUrl: tutorial.video,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                tutorial.photoCreator,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(tutorial.photoCreator),
                                      radius: 28,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tutorial.judul,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            tutorial.creator,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MarketPricePage extends StatelessWidget {
  const MarketPricePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan tombol sortir
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Pasar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Righteous',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Daftar fruit card
            Expanded(
              child: FutureBuilder<List<MarketPrice>>(
                future: apiService.getMarket(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No market prices found'));
                  } else {
                    final marketPrices = snapshot.data!;
                    return ListView.builder(
                      itemCount: (marketPrices.length / 3).ceil(),
                      itemBuilder: (context, rowIndex) {
                        final startIndex = rowIndex * 3;
                        final endIndex =
                            (startIndex + 3).clamp(0, marketPrices.length);
                        final rowItems =
                            marketPrices.sublist(startIndex, endIndex);
                        return Container(
                          color: rowIndex.isEven
                              ? Colors.white
                              : Colors.grey[
                                  200], // Latar belakang baris ganjil dan genap
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: rowItems.map((marketPrice) {
                              return FruitCardH(
                                id: marketPrice.id,
                                name: marketPrice.namaBuah,
                                imagePath: marketPrice.potoBuah,
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            // Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xff00813E),
                ),
                const Text(
                  "Page 1 of 5",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                  color: const Color(0xff00813E),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FruitCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int id;

  const FruitCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      width: 130,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MarketPriceDetailPage(
              id: id,
              name: name,
              imagePath: imagePath,
            );
          }));
        },
        child: Card(
          color: Colors.white, // Latar belakang putih
          elevation: 3, // Menambahkan shadow
          shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Radius card
            side: BorderSide(
                color: Colors.green.withOpacity(0.3),
                width: 1), // Border hijau yang lebih lembut
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding 10 di setiap sisi
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  imagePath,
                  width: 75, // Lebar gambar agar proporsional
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 8), // Spasi antara gambar dan teks
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FruitCardH extends StatelessWidget {
  final String name;
  final String imagePath;
  final int id;

  const FruitCardH({
    super.key,
    required this.name,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      width: 130,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MarketPriceDetailPage(
              id: id,
              name: name,
              imagePath: imagePath,
            );
          }));
        },
        child: Card(
          color: Colors.white, // Latar belakang putih
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Radius card
            side: const BorderSide(
                color: Colors.black, width: .3), // Border hitam
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0), // Padding 10 di setiap sisi
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  imagePath,
                  width: 75, // Lebar gambar agar proporsional
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 8), // Spasi antara gambar dan teks
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Tutorial",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Righteous',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Tutorial>>(
              future: apiService.getTutorials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Gagal Memuat Data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tutorial Tidak Ditemukan'));
                } else {
                  final tutorials = snapshot.data!;
                  return Column(
                    children: [
                      // Card besar - video utama
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TutorialDetailPage(
                                title: tutorials[0].judul,
                                publisher: tutorials[0].creator,
                                description: tutorials[0].deskripsi,
                                imageUrl: tutorials[0].photoCreator,
                                videoUrl: tutorials[0].video,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                tutorials[0].photoCreator,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          tutorials[0].photoCreator),
                                      radius: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tutorials[0].judul,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            tutorials[0].creator,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Card kecil untuk tutorial lainnya
                      for (int i = 1; i < tutorials.length; i++)
                        _buildSmallCard(
                          context,
                          tutorials[i].judul,
                          tutorials[i].creator,
                          tutorials[i].photoCreator,
                          tutorials[i].deskripsi,
                          tutorials[i].video,
                          isGreyBackground: i % 2 == 0,
                        ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(BuildContext context, String title, String publisher,
      String photoCreator, String description, String videoUrl,
      {required bool isGreyBackground}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorialDetailPage(
              title: title,
              publisher: publisher,
              description: description,
              imageUrl: photoCreator,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Card(
        color: isGreyBackground ? Colors.grey[200] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                photoCreator,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoCreator),
                          radius: 12,
                        ),
                        const SizedBox(width: 10),
                        Text(publisher,
                            style: const TextStyle(color: Colors.grey)),
                      ],
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

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  late Future<List<Obat>> futureObats;

  @override
  void initState() {
    super.initState();
    futureObats = ApiService().getObats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card utama dengan background gambar dan teks di dalamnya
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage("asset/img/post.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Text(
                    "Informasi Tentang Obat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
                const Positioned(
                  right: 16,
                  bottom: 16,
                  child: Text(
                    "Tanggal post: 01-10-2024",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tab jenis obat
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.green,
                      tabs: [
                        Tab(text: "Cair"),
                        Tab(text: "Bubuk"),
                        Tab(text: "Pupuk"),
                      ],
                    ),
                    SizedBox(
                      height: 420, // Tinggi tab view untuk card-card obat
                      child: FutureBuilder<List<Obat>>(
                        future: futureObats,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No data available'));
                          } else {
                            final obats = snapshot.data!;
                            return TabBarView(
                              children: [
                                _buildJenisObatTab(obats, "Cair"),
                                _buildJenisObatTab(obats, "Bubuk"),
                                _buildJenisObatTab(obats, "Pupuk"),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun isi tab obat dengan card-card
  Widget _buildJenisObatTab(List<Obat> obats, String type) {
    final filteredObats = obats.where((obat) => obat.jenis == type).toList();
    return ListView.builder(
      itemCount: filteredObats.length,
      itemBuilder: (context, index) {
        final obatDetail = filteredObats[index].obats;
        return Column(
          children: obatDetail.map((obat) {
            bool isOdd = index % 2 == 0;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ObatDetailPage(
                      name: obat.namaObat,
                      imagePath: obat.photoObat,
                      description: obat.deskripsi,
                      fungsiobats: obat.fungsiobats,
                    ),
                  ),
                );
              },
              child: Card(
                color: isOdd ? Colors.grey[200] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        obat.photoObat,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              obat.namaObat,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              obat.deskripsi,
                              style: const TextStyle(color: Colors.grey),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2, // Batas maksimal baris teks
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final WeatherService _weatherService = WeatherService();

  late double lat;
  late double lon;

  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      Position position = await _weatherService.getCurrentPosition();
      lat = position.latitude;
      lon = position.longitude;

      final currentData =
          await _weatherService.fetchWeatherDataByLocation(lat, lon);
      return {
        'current': currentData,
      };
    } catch (e) {
      throw Exception('Gagal mendapatkan data cuaca: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> forecastWeather() async {
    try {
      Position position = await _weatherService.getCurrentPosition();
      lat = position.latitude;
      lon = position.longitude;

      return await _weatherService.fetchForecastDataByLocation(lat, lon);
    } catch (e) {
      throw Exception('Gagal mendapatkan data forecast: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, dd MMM').format(DateTime.now());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul dengan tombol "Location" dan icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cuaca",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Tindakan ketika tombol location ditekan
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('Lokasi'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Tanggal yang akan ditampilkan secara dinamis
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff00813E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    formattedDate, // Menampilkan tanggal yang sudah diformat
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Gambar cuaca di tengah
              FutureBuilder<Map<String, dynamic>>(
                future: fetchWeather(), // Memanggil fetchWeather
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Tampilkan loading
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            "Gagal Memuat Data")); // Tampilkan error jika ada
                  } else if (snapshot.hasData) {
                    var currentWeatherData = snapshot.data!['current'];
                    var weatherCondition =
                        currentWeatherData['weather'][0]['main'];
                    String imagePath = getWeatherImage(weatherCondition);

                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            imagePath,
                            height: 150,
                            width: 150,
                          ),
                          Text(
                            "${currentWeatherData['main']['temp'].toInt()}°C",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff00813E),
                            ),
                          ),
                          Text(
                            currentWeatherData['weather'][0]['description'],
                            style: const TextStyle(
                                fontSize: 26, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('Data Tidak Tersedia'));
                  }
                },
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xff00813E),
                  // Warna hijau
                  borderRadius: BorderRadius.circular(8), // Sudut melengkung
                ),
                child: const Text(
                  'Rekomendasi Tanaman',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: FutureBuilder<Map<String, dynamic>>(
                  future: fetchWeather(), // Memanggil fetchWeather
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Gagal Memuat Data"));
                    } else if (snapshot.hasData) {
                      var currentWeatherData = snapshot.data!['current'];
                      var temperature = currentWeatherData['main']['temp'];
                      var weatherCondition =
                          currentWeatherData['weather'][0]['main'];
                      var humidity = currentWeatherData['main']['humidity'];
                      var rainfall = currentWeatherData['rain'] != null
                          ? currentWeatherData['rain']['1h']
                          : 0.0;

                      // Rekomendasi tanaman berdasarkan suhu atau cuaca
                      List<Map<String, String>> recommendations =
                          getPlantRecommendations(
                        temperature,
                        weatherCondition,
                        humidity,
                        rainfall,
                      );

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendations.length,
                        itemBuilder: (context, index) {
                          var plant = recommendations[index];
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  plant['imagePath']!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  plant['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('Data Tidak Tersedia'));
                    }
                  },
                ),
              ),

              const SizedBox(height: 10),
              // Judul Cuaca Minggu Ini
              const Text(
                "Prakiraan Cuaca Harian",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Daftar cuaca
              FutureBuilder<List<Map<String, dynamic>>?>(
                future: forecastWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Gagal memuat data cuaca'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('Data tidak tersedia'));
                  }

                  final forecasts = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap:
                        true, // Agar ListView bekerja dengan SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: forecasts.length,
                    itemBuilder: (context, index) {
                      final forecast = forecasts[index];
                      final isOdd = index % 2 == 1;

                      return Card(
                        color: isOdd ? Colors.grey[200] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Tanggal
                              Text(
                                getDayName(forecast['date']),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    getWeatherImage(forecast['icon']),
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    forecast['weather'], // Deskripsi cuaca
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              // Suhu
                              Text(
                                "${forecast['temp']}°C",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pencarian",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field pencarian
            TextField(
              decoration: InputDecoration(
                hintText: "Cari...",
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Bagian riwayat pencarian
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.history, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Riwayat Pencarian",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    // Tindakan untuk menghapus riwayat pencarian
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Daftar riwayat pencarian (contoh statis)
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text("Pencarian 1"),
                    leading: Icon(Icons.search, color: Colors.green),
                  ),
                  ListTile(
                    title: Text("Pencarian 2"),
                    leading: Icon(Icons.search, color: Colors.green),
                  ),
                  ListTile(
                    title: Text("Pencarian 3"),
                    leading: Icon(Icons.search, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _postController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPostingButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isPostingButtonVisible = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _postController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Post",
            style: TextStyle(fontSize: 24, color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        // Membungkus konten dalam SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _postController,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: "Tulis sesuatu...",
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
              // Tombol "Posting" muncul saat TextField ditekan
              if (_isPostingButtonVisible)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Fungsi untuk memposting konten
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Video Baru",
                      style: TextStyle(
                          fontFamily: "Righteous", color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 5),
              // Tombol "Video Baru" dan "Foto Baru" di luar TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk menambahkan video
                    },
                    icon: const Icon(Icons.video_camera_back,
                        color: Colors.white),
                    label: const Text("Video Baru"),
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xff00813E),
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk menambahkan foto
                    },
                    icon: const Icon(Icons.photo_camera, color: Colors.white),
                    label: const Text("Foto Baru"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00813E),
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Judul untuk "Postingan dari Petani Lain"
              const Text(
                "Postingan dari Petani Lain",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true, // Agar ListView menyesuaikan ukuran konten
                physics:
                    const NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada ListView agar tidak bentrok dengan SingleChildScrollView
                itemCount: 3, // Contoh jumlah postingan
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama pengguna dan waktu posting
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("asset/img/profil.jpg"),
                                radius: 20,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Petani ${index + 1}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "2 jam yang lalu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Konten postingan
                          const Text(
                            "Ini adalah contoh postingan dari petani lain. Informasi mengenai produk atau aktivitas terkini.",
                          ),
                          const SizedBox(height: 10),
                          // Gambar di postingan (opsional)
                          Image.asset(
                            "asset/img/post.png",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          // Tombol like dan komentar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  // Aksi ketika tombol Like ditekan
                                },
                                icon: const Icon(Icons.thumb_up_alt_outlined),
                                label: const Text("Like"),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  // Aksi ketika tombol Komentar ditekan
                                },
                                icon: const Icon(Icons.comment_outlined),
                                label: const Text("Komentar"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
