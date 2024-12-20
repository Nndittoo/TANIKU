import 'package:flutter/material.dart';
import 'package:taniku/page/auth/login.dart';
import 'package:taniku/page/home.dart';
import 'package:taniku/page/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Profil",
            style: TextStyle(fontSize: 24, color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildProfileSection(),
                const SizedBox(height: 20),
                _buildGridMenu(context),
                const SizedBox(height: 20),
                _buildListMenu(context),
              ],
            ),
          ),
          _buildDecorativeCircles(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    final user = AuthService().user;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user.photoURL?.isNotEmpty == true
                  ? NetworkImage(user.photoURL!)
                  : const AssetImage("asset/img/profile_default.png")
                      as ImageProvider,
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xff00813E),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          user.displayName ?? "Nama Pengguna",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Menu Grid
  Widget _buildGridMenu(BuildContext context) {
    final items = [
      {
        "icon": Icons.add,
        "label": "Posting",
        "onPressed": () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddPostPage()))
      },
      {"icon": Icons.attach_money, "label": "Harga", "onPressed": () => {}},
      {"icon": Icons.video_call, "label": "Tutorial", "onPressed": () => {}},
      {"icon": Icons.cloud, "label": "Cuaca", "onPressed": () => {}},
      {"icon": Icons.water_drop, "label": "Obat", "onPressed": () => {}},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: item["onPressed"] as VoidCallback,
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xff00813E),
                child: Icon(item["icon"] as IconData,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(height: 5),
              Text(
                item["label"] as String,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  // Menu List
  Widget _buildListMenu(BuildContext context) {
    final items = [
      {
        "icon": Icons.search,
        "label": "Cari Di Taniku",
        "onPressed": () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage()))
      },
      {
        "icon": Icons.settings,
        "label": "Pengaturan",
        "onPressed": () => print("Pengaturan button pressed")
      },
      {
        "icon": Icons.logout,
        "label": "Keluar",
        "onPressed": () {
          _bulidPopup();
        }
      },
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading:
                Icon(item["icon"] as IconData, color: const Color(0xff00813E)),
            title: Text(item["label"] as String),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: item["onPressed"] as VoidCallback,
          ),
        );
      }).toList(),
    );
  }

  // Dekorasi Lingkaran
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

  void _bulidPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'asset/img/pintu.png', // Path ke gambar
              width: 153,
              height: 194,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ohh tidak!! Anda akan keluar...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Anda yakin?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff00813E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tidak dong',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Ya, Keluar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
