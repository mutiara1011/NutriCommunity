import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== HEADER ======
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profil",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // ⚙ SETTINGS BUTTON
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.settings, size: 28),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== PROFILE CARD =====
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EED6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: const Color(0xFF398A57),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // NAME + LEVEL
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Mutiara",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Level 3",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // STAR ICON (favorite)
                    const Icon(Icons.star, color: Color(0xFFF0AB4C), size: 30),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ====== XP BAR ======
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EED6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // XP BAR
                    Stack(
                      children: [
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 180, // current XP progress
                          decoration: BoxDecoration(
                            color: const Color(0xFF398A57),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Next level in 150 XP",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ======= STATS CARDS =======
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _statCard(Icons.arrow_upward, "Highest Rank", "Top 5%"),
                    const SizedBox(width: 12),
                    _statCard(Icons.emoji_events, "Current Rank", "Ranked 15"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _statCard(Icons.verified, "Total Badges", "8 Badges"),
                    const SizedBox(width: 12),
                    _statCard(Icons.list_alt, "Misi Selesai", "42 Misi"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ======= BADGES SECTION =========
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Badges",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _badgeCircle(Colors.orange, Icons.star),
                    const SizedBox(width: 14),
                    _badgeCircle(Colors.orange.shade300, Icons.verified_user),
                    const SizedBox(width: 14),
                    _badgeCircle(Colors.grey.shade700, Icons.check_circle),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios, size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // === SMALL REUSABLE WIDGETS ===

  Widget _statCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8EED6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(value, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _badgeCircle(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white),
    );
  }
}
