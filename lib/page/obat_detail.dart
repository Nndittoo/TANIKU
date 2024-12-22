import 'package:flutter/material.dart';
import 'package:taniku/api/api_taniku.dart';
import 'package:taniku/models/obat_model.dart';
import 'package:taniku/models/tutorial_model.dart';
import 'package:taniku/page/tutorial_detail.dart';

class ObatDetailPage extends StatelessWidget {
  final int id;
  final String name;
  final String imagePath;
  final String description;
  final List<FungsiDetail> fungsiobats;

  const ObatDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.fungsiobats,
  });

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
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
              Image.network(
                imagePath,
                width: 401,
                height: 213,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
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
                      color: Color(0xff00813E),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(description,
                      style: const TextStyle(
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
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fungsiobats.length,
                      itemBuilder: (context, index) {
                        final fungsiObat = fungsiobats[index];
                        return _buildCardFungsi(
                          fungsiObat.fungsi,
                          fungsiObat.potoFungsi,
                        );
                      },
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
                  FutureBuilder<List<Tutorial>>(
                    future: apiService.getTutorials(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Gagal memuat data'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada video obat'));
                      } else {
                        final tutorials = snapshot.data!
                            .where((tutorial) => tutorial.idObat == id)
                            .toList();
                        return Column(
                          children: tutorials.map((tutorial) {
                            return _buildSmallCard(
                              context,
                              tutorial.id,
                              tutorial.judul,
                              tutorial.creator,
                              tutorial.photoCreator,
                              tutorial.deskripsi,
                              tutorial.video,
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardFungsi(String title, String imagePath) {
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
              child: Image.network(
                imagePath, // Gambar sesuai parameter
                width: 138,
                height: 109,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
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
      ),
    );
  }

  Widget _buildSmallCard(
    BuildContext context,
    int id,
    String title,
    String publisher,
    String photoCreator,
    String description,
    String videoUrl,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorialDetailPage(
              id: id,
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
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  photoCreator,
                  width: 129,
                  height: 116,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00813E),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoCreator),
                          radius: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(publisher,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            )),
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
