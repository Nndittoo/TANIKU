import 'package:flutter/material.dart';

class TutorialDetailPage extends StatelessWidget {
  final String title;
  final String publisher;

  const TutorialDetailPage(
      {super.key, required this.title, required this.publisher});

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
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset('asset/img/post.png'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'asset/img/profil.jpg',
                    ),
                    radius: 28,
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
                              fontWeight: FontWeight.w500),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          publisher,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff00813E),
                    // Warna hijau
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Deskripsi Video",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Selamat datang di video kami! Dalam video ini, kami akan menunjukkan cara yang tepat untuk memetik daun teh agar kualitasnya tetap terjaga. Anda akan belajar langkah demi langkah tentang teknik pemetikan yang benar, alat yang dibutuhkan, serta tips untuk memastikan daun teh yang dipetik segar dan optimal.\n\n"
                    "Ikuti kami di kebun teh yang indah dan saksikan proses pemetikan yang tidak hanya bermanfaat, tetapi juga menyenangkan. Apakah Anda seorang pemula atau sudah berpengalaman, video ini akan memberikan wawasan berharga tentang dunia teh. Jangan lupa untuk like, komentar, dan subscribe untuk konten menarik lainnya!\n"
                    "Selamat menonton!",
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff00813E),
                    // Warna hijau
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Video Lainnya",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                              backgroundImage:
                                  AssetImage('asset/img/profil.jpg'),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Jumlah penonton',
                                  style: TextStyle(fontSize: 14),
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
          ])),
    );
  }
}
