import 'package:flutter/material.dart';
import 'package:taniku/page/auth/login.dart';
import 'package:taniku/page/auth/register.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Bola di sudut kanan atas
            Positioned(
              top: 0,
              right: 0,
              width: 100,
              child: Image.asset('asset/img/bola-atas.png'),
            ),
            // Bola di sudut kiri bawah
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'asset/img/bola-bawah.png',
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'asset/img/bola-kecil-bawah.png',
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
            // Konten di tengah layar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'asset/img/logo.png',
                  width: 250, // Sesuaikan ukuran logo
                  height: 190,
                ),
                const SizedBox(height: 20), // Spasi antara logo dan judul
                // Judul
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Selamat datang di Taniku',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Righteous',
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Spasi antara judul dan paragraf
                // Paragraf
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Untuk melanjutkan aplikasi, silahkan Masuk jika sudah mempunyai akun dan Daftar untuk mendaftar akun baru.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Spasi antara paragraf dan tombol
                // Tombol
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff00813E),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Mengatur radius
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),

                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Latar belakang button transparan
                      padding: EdgeInsets.zero, // Menghilangkan padding default
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Color(0xff000000), // Warna teks hitam
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
