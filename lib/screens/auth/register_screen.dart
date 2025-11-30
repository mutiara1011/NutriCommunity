import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/custom_textfield.dart';
import '../../main.dart'; // untuk baseUrl

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscurePass = true;
  bool obscureConfirm = true;

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> registerUser() async {
    final user = username.text.trim();
    final mail = email.text.trim();
    final pass = password.text;
    final confirm = confirmPassword.text;

    if (user.isEmpty || mail.isEmpty || pass.isEmpty || confirm.isEmpty) {
      showMsg("Semua field harus diisi!");
      return;
    }

    if (pass != confirm) {
      showMsg("Password tidak sama!");
      return;
    }

    try {
      final url = Uri.parse('$baseUrl/user/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': user, 'email': mail, 'password': pass}),
      );

      // Cek apakah response body kosong
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = data['status']?['message'] ?? "Registrasi berhasil";
        showMsg(message);

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        final message =
            data['status']?['message'] ?? "Registrasi gagal, coba lagi";
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
                  "Register",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomTextField(controller: username, label: "Username"),
                const SizedBox(height: 12),
                CustomTextField(controller: email, label: "E-mail"),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: password,
                  label: "Password",
                  isPassword: true,
                  obscure: obscurePass,
                  onToggle: () => setState(() => obscurePass = !obscurePass),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: confirmPassword,
                  label: "Confirm Password",
                  isPassword: true,
                  obscure: obscureConfirm,
                  onToggle: () =>
                      setState(() => obscureConfirm = !obscureConfirm),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB300),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Register"),
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Have an account? Login",
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
