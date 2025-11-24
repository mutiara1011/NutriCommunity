import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: Stack(
        children: [
          // 📌 BACKGROUND DI TENGAH
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(
                'assets/images/background.png',
                height: MediaQuery.of(context).size.height * 0.40,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 📌 LOGO DI ATAS TENGAH (TIDAK IKUT KONTEN)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.175, // jarak dari atas
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset('assets/images/logo.png', height: 115),
            ),
          ),

          // 📌 KONTEN UTAMA DI TENGAH
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),

                Text(
                  "Selamat Datang",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Yuk, mulai gaya hidup sehat bareng kami!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 90),

                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB300),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 65, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white, width: 2),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Daftar Akun Baru",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
