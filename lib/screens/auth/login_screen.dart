import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/custom_textfield.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePass = true;

  final username = TextEditingController();
  final password = TextEditingController();

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> loginUser() async {
    final user = username.text.trim();
    final pass = password.text;

    if (user.isEmpty || pass.isEmpty) {
      showMsg("Username dan password tidak boleh kosong");
      return;
    }

    try {
      final url = Uri.parse('$baseUrl/user/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': user, 'password': pass}),
      );

      // Pastikan body tidak kosong
      if (response.body.isEmpty) {
        showMsg("Server tidak merespons atau body kosong");
        return;
      }

      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        showMsg("Response bukan JSON valid: ${response.body}");
        return;
      }

      if (response.statusCode == 200) {
        final token = data['token'];
        if (token != null && token is String && token.isNotEmpty) {
          globalToken = token;

          // simpan persistennya
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          showMsg("Login gagal: token tidak diterima");
        }
      } else {
        final message = data['status']?['message'] ?? 'Login gagal, coba lagi';
        showMsg(message);
      }
    } catch (e) {
      showMsg("Terjadi kesalahan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7DE),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 80),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomTextField(controller: username, label: "Username"),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: password,
                  label: "Password",
                  isPassword: true,
                  obscure: obscurePass,
                  onToggle: () {
                    setState(() => obscurePass = !obscurePass);
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB300),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Login"),
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
