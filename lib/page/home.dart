import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/page/auth/login.dart';
import 'package:pemrograman_mobile/page/auth/register.dart';
import 'package:pemrograman_mobile/page/profil.dart';
import 'package:pemrograman_mobile/page/search.dart';

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
          padding: EdgeInsets.all(8.0),
          child: Image.asset("asset/img/logo-daun.png"),
        ),
        title: Text(
          "Taniku",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontFamily: "Righteous",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mark_email_unread_outlined),
            color: Colors.black87,
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: CircleAvatar(
              backgroundImage: AssetImage("asset/img/profil.jpg"),
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
          MarketPricePage(), // Halaman kedua
          TutorialPage(), // Halaman ketiga
          ObatPage(), // Halaman keempat
          CuacaPage(), // Halaman kelima
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPostPage()));
              }, // Aksi untuk tambah postingan
              backgroundColor: const Color(0xff00813E),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              }, // Aksi untuk pencarian
              backgroundColor: const Color(0xff00813E),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              mini: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff00813E),
        currentIndex: _currentIndex, // Setel indeks aktif
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index); // Berpindah halaman
          });
        },
        items: [
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

  Widget buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/img/bg-cuaca.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Medan Selayang",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "27°C",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            "Hujan",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("More info",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("asset/img/hujan.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Pasar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MarketPricePage()));
                  },
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xff00813E),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FruitCardH(
                      name: 'Apple',
                      price: 'Rp 10.000/kg',
                      imagePath: 'asset/img/jeruk.png'),
                  FruitCardH(
                      name: 'Orange',
                      price: 'Rp 15.000/kg',
                      imagePath: 'asset/img/jeruk.png'),
                  FruitCardH(
                      name: 'Banana',
                      price: 'Rp 8.000/kg',
                      imagePath: 'asset/img/jeruk.png'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posting",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
                      color: const Color(0xff00813E),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "asset/img/post.png",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Deskripsi postingan...",
                      style: TextStyle(fontSize: 16),
                    ),
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

class MarketPricePage extends StatelessWidget {
  const MarketPricePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan tombol sortir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Pasar",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.sort, color: const Color(0xff00813E)),
                  label: Text(
                    "Sortir",
                    style: TextStyle(color: const Color(0xff00813E)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Daftar fruit card
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, rowIndex) {
                  return Container(
                    color: rowIndex.isEven
                        ? Colors.white
                        : Colors
                            .grey[200], // Latar belakang baris ganjil dan genap
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FruitCard(
                            name: 'Bawang Putih',
                            price: 'Rp 10.000/kg',
                            imagePath: 'asset/img/jeruk.png'),
                        FruitCard(
                            name: 'Orange',
                            price: 'Rp 15.000/kg',
                            imagePath: 'asset/img/jeruk.png'),
                        FruitCard(
                            name: 'Banana',
                            price: 'Rp 8.000/kg',
                            imagePath: 'asset/img/jeruk.png'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            // Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                  color: const Color(0xff00813E),
                ),
                Text(
                  "Page 1 of 5",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
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
  final String price;
  final String imagePath;

  const FruitCard({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      width: 130,
      child: InkWell(
        onTap: () {
          // Action when the card is pressed
        },
        child: Card(
          color: Colors.white, // Latar belakang putih
          elevation: 3, // Menambahkan shadow
          shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Radius card
            side: BorderSide(
                color: const Color(0xff00813E).withOpacity(0.3),
                width: 1), // Border hijau yang lebih lembut
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding 10 di setiap sisi
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 70, // Lebar gambar agar proporsional
                  height: 70,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8), // Spasi antara gambar dan teks
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: TextStyle(
                    color: const Color(0xff00813E),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
  final String price;
  final String imagePath;

  const FruitCardH({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 150,
      child: Card(
        color: Colors.white, // Latar belakang putih
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Radius card
          side: BorderSide(color: Colors.black, width: .3), // Border hitam
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0), // Padding 10 di setiap sisi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 75, // Lebar gambar agar proporsional
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8), // Spasi antara gambar dan teks
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: const Color(0xff00813E),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
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

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Tutorial",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Card besar - video utama
            Card(
              color: Colors.white, // Latar belakang putih untuk Card besar
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Thumbnail
                  Image.asset(
                    "asset/img/post.png",
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
                          backgroundImage: AssetImage("asset/img/profil.jpg"),
                          radius: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Judul Video Utama",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Nama Penerbit",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "120K views • 2 hari yang lalu",
                                style: TextStyle(color: Colors.grey),
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
            SizedBox(height: 20),
            // Card kecil pertama - latar belakang abu-abu
            _buildSmallCard("Judul Video 1", "Nama Penerbit",
                "90K views • 1 minggu yang lalu",
                isGreyBackground: true),
            // Card kecil kedua - latar belakang putih
            _buildSmallCard("Judul Video 2", "Nama Penerbit",
                "80K views • 3 hari yang lalu",
                isGreyBackground: false),
            // Card kecil ketiga - latar belakang abu-abu
            _buildSmallCard("Judul Video 3", "Nama Penerbit",
                "70K views • 5 hari yang lalu",
                isGreyBackground: true),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun Card kecil dengan parameter latar belakang
  Widget _buildSmallCard(String title, String publisher, String views,
      {required bool isGreyBackground}) {
    return Card(
      color: isGreyBackground ? Colors.grey[200] : Colors.white,
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
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/img/profil.jpg"),
                        radius: 12,
                      ),
                      SizedBox(width: 8),
                      Text(publisher),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    views,
                    style: TextStyle(color: Colors.grey),
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

class ObatPage extends StatelessWidget {
  const ObatPage({super.key});

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
                    image: DecorationImage(
                      image: AssetImage("asset/img/post.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Text(
                    "Informasi Tentang Obat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
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
            SizedBox(height: 20),
            // Tab jenis obat
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xff00813E),
                      tabs: [
                        Tab(text: "Cair"),
                        Tab(text: "Bubuk"),
                        Tab(text: "Pupuk"),
                      ],
                    ),
                    SizedBox(
                      height: 420, // Tinggi tab view untuk card-card obat
                      child: TabBarView(
                        children: [
                          _buildObatTabContent("Cair"),
                          _buildObatTabContent("Bubuk"),
                          _buildObatTabContent("Pupuk"),
                        ],
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
  Widget _buildObatTabContent(String type) {
    return ListView.builder(
      itemCount: 6, // Jumlah card sebagai contoh
      itemBuilder: (context, index) {
        bool isOdd = index % 2 == 0;
        return Card(
          color: isOdd ? Colors.grey[200] : Colors.white,
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
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Judul Obat $type ${index + 1}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Deskripsi singkat tentang obat jenis $type. "
                        "Obat ini digunakan untuk mengatasi masalah tertentu.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dengan tombol "Location" dan icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                  icon: Icon(Icons.location_on),
                  label: Text("Location"),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Kontainer dengan latar belakang hijau dan border radius untuk tanggal
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff00813E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Kamis, 01 Sep",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Gambar cuaca di tengah
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "asset/img/hujan.png", // Ganti dengan path gambar cuaca
                    height: 150, // Sesuaikan ukuran gambar
                    width: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "25°C", // Suhu cuaca
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Cerah", // Deskripsi cuaca
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Judul Cuaca Minggu Ini
            Text(
              "Cuaca Minggu Ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Daftar cuaca
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Jumlah hari dalam seminggu
                itemBuilder: (context, index) {
                  bool isOdd = index % 2 == 0; // Genap atau ganjil
                  List<String> days = [
                    "Senin",
                    "Selasa",
                    "Rabu",
                    "Kamis",
                    "Jumat",
                    "Sabtu",
                    "Minggu"
                  ];
                  List<String> weatherDescriptions = [
                    "Cerah",
                    "Mendung",
                    "Hujan",
                    "Badai",
                    "Cerah",
                    "Mendung",
                    "Hujan"
                  ];
                  List<String> weatherIcons = [
                    "asset/img/hujan.png",
                    "asset/img/cerah.png",
                    "asset/img/mendung.png",
                    "asset/img/hujan.png",
                    "asset/img/mendung.png",
                    "asset/img/mendung.png",
                    "asset/img/hujan.png"
                  ];

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
                          Text(
                            days[index], // Menggunakan nama hari
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                weatherIcons[index], // Icon cuaca yang berbeda
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: 8),
                              Text(
                                weatherDescriptions[index], // Deskripsi cuaca
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "${20 + index}°C", // Ganti dengan suhu aktual
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Pencarian"),
            ),
            Spacer(), // Spacer kedua untuk menjaga posisi teks tetap di tengah
          ],
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
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Bagian riwayat pencarian
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    // Tindakan untuk menghapus riwayat pencarian
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            // Daftar riwayat pencarian (contoh statis)
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Pencarian 1"),
                    leading: Icon(Icons.search, color: const Color(0xff00813E)),
                  ),
                  ListTile(
                    title: Text("Pencarian 2"),
                    leading: Icon(Icons.search, color: const Color(0xff00813E)),
                  ),
                  ListTile(
                    title: Text("Pencarian 3"),
                    leading: Icon(Icons.search, color: const Color(0xff00813E)),
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
  _AddPostPageState createState() => _AddPostPageState();
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
      body: SingleChildScrollView(
        // Membungkus konten dalam SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali dan judul
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Text Field untuk menulis postingan
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _postController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
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
                      backgroundColor: const Color(0xff00813E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Video Baru",
                      style: TextStyle(
                        fontFamily: "Righteous",
                          color: Colors.white), // Atur warna teks menjadi putih
                    ),
                  ),
                ),

              SizedBox(height: 5),
              // Tombol "Video Baru" dan "Foto Baru" di luar TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk menambahkan video
                    },
                    icon: Icon(Icons.video_camera_back, color: Colors.white),
                    label: Text("Video Baru"),
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xff00813E),
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk menambahkan foto
                    },
                    icon: Icon(Icons.photo_camera, color: Colors.white),
                    label: Text("Foto Baru"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00813E),
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Judul untuk "Postingan dari Petani Lain"
              Text(
                "Postingan dari Petani Lain",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true, // Agar ListView menyesuaikan ukuran konten
                physics:
                    NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada ListView agar tidak bentrok dengan SingleChildScrollView
                itemCount: 3, // Contoh jumlah postingan
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
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
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("asset/img/profil.jpg"),
                                radius: 20,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Petani ${index + 1}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
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
                          SizedBox(height: 10),
                          // Konten postingan
                          Text(
                            "Ini adalah contoh postingan dari petani lain. Informasi mengenai produk atau aktivitas terkini.",
                          ),
                          SizedBox(height: 10),
                          // Gambar di postingan (opsional)
                          Image.asset(
                            "asset/img/post.png",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          // Tombol like dan komentar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  // Aksi ketika tombol Like ditekan
                                },
                                icon: Icon(Icons.thumb_up_alt_outlined),
                                label: Text("Like"),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  // Aksi ketika tombol Komentar ditekan
                                },
                                icon: Icon(Icons.comment_outlined),
                                label: Text("Komentar"),
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
