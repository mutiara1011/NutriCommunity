import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_textfield.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString("username");
    String? savedPass = prefs.getString("password");

    if (username.text.isEmpty || password.text.isEmpty) {
      showMsg("Username dan password tidak boleh kosong");
      return;
    }

    if (savedUser == null) {
      showMsg("Akun belum terdaftar!");
      return;
    }

    if (username.text != savedUser) {
      showMsg("Username tidak ditemukan!");
      return;
    }

    if (password.text != savedPass) {
      showMsg("Password salah!");
      return;
    }

    if (!mounted) return;

    // Login sukses
    Navigator.pushReplacementNamed(context, '/main');
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
