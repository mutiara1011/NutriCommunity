import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_textfield.dart';

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
    if (username.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showMsg("Semua field harus diisi!");
      return;
    }

    if (password.text != confirmPassword.text) {
      showMsg("Password tidak sama!");
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Cek email sudah dipakai
    if (prefs.getString("email") == email.text) {
      showMsg("Email sudah terdaftar!");
      return;
    }

    // Simpan data user
    prefs.setString("username", username.text);
    prefs.setString("email", email.text);
    prefs.setString("password", password.text);

    showMsg("Registrasi berhasil, silakan login!");
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
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
