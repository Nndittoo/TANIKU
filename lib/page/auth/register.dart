import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/page/auth/login.dart';
import 'package:pemrograman_mobile/page/home.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("asset/img/bola-atas.png"),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset("asset/img/bola-tipis-bawah.png"),
            ),
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/img/logo-daun.png',
                          width: 120,
                        ),
                        Text(
                          "Daftar",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Daftar Akun Baru",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff00813E),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Nama Lengkap",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Konfirmasi Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff00813E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Masuk dengan",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              },
                              icon: Image.asset(
                                'asset/img/facebook.png',
                                width: 45,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              },
                              icon: Image.asset(
                                "asset/img/google.png",
                                width: 45,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah punya akun?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: Text(
                                " Masuk",
                                style: TextStyle(
                                  color: const Color(0xff00813E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
