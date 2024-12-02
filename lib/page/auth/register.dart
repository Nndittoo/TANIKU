import 'dart:developer';
import 'auth_service.dart';
import 'package:flutter/material.dart';
import 'package:taniku/page/auth/login.dart';
import 'package:taniku/page/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Validasi input
    if (_name.text.isEmpty || _email.text.isEmpty || _password.text.isEmpty) {
      _showSnackBar("Tolong masukkan nama, email, atau password Anda");
      return;
    }
    if (_password.text != _confirmPassword.text) {
      _showSnackBar("Password tidak sama");
      return;
    }
    try {
      // Registrasi pengguna
      final user = await _auth.createUserWithEmailAndPassword(
        _email.text,
        _password.text,
        _name.text,
      );
      if (user != null) {
        _showSnackBar("Registrasi berhasil. Selamat datang!");
        goToHome(context); // Navigasi ke halaman berikutnya
      }
    } catch (e) {
      if (e is Exception) {
        _showSnackBar(e.toString().replaceFirst("Exception: ", ""));
      } else {
        _showSnackBar("Terjadi kesalahan tidak terduga.");
      }
    }
  }

  Future<void> _loginGoogle() async {
    final user = await AuthService().signInWithGoogle();
    if (user != null) {
      log("User logged in");
      goToHome(context);
    } else {
      _showSnackBar("Register gagal, coba lagi");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  goToLogin(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));

  goToHome(BuildContext context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (Route<dynamic> route) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/img/logo-daun.png',
                        width: 120,
                      ),
                      const Text(
                        "Daftar",
                        style: TextStyle(
                          fontFamily: "Righteous",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Daftar Akun Baru",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff00813E),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(_name, "Nama Lengkap"),
                              const SizedBox(height: 20),
                              _buildTextField(_email, "Email",
                                  keyboardType: TextInputType.emailAddress),
                              const SizedBox(height: 20),
                              _buildTextField(_password, "Password",
                                  obscureText: true),
                              const SizedBox(height: 20),
                              _buildTextField(
                                  _confirmPassword, "Konfirmasi Password",
                                  obscureText: true),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _register,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff00813E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
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
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => {},
                            icon: Image.asset(
                              'asset/img/facebook.png',
                              width: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: _loginGoogle,
                            icon: Image.asset(
                              "asset/img/google.png",
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sudah punya akun?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => goToLogin(context),
                            child: const Text(
                              " Masuk",
                              style: TextStyle(
                                color: Color(0xff00813E),
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
