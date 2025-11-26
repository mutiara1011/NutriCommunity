import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // DATA QUEST
    final quests = [
      {"title": "Minum 1 gelas air", "xp": 10},
      {"title": "Posting Pencapaian", "xp": 30},
      {"title": "Beri like 1 postingan", "xp": 10},
      {"title": "Makan 1 Porsi Buah", "xp": 15},
    ];

    // STREAK DATA
    int currentStreak = 5;
    int maxStreak = 10;
    double streakProgress = currentStreak / maxStreak;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // ================== HEADER =====================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: const BoxDecoration(color: Color(0xFF398A57)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi, Mutiara",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF9F4E7),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 30),
                  ),
                ],
              ),
            ),

            // ================ STREAK CARD ===================
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: const Color(0xFFFFFBEA)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Streak",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "5 days",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 12),

                      // --- STREAK BAR HERE ---
                      Stack(
                        children: [
                          // Background bar
                          Container(
                            width: 140,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          // Filled bar (progress)
                          Container(
                            width: 140 * (streakProgress),
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF398A57),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // XP CARD
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0AB4C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "850 Xp",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================== RECOMMENDATION =======================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Today's recommendations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 15),

            Column(
              children: List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 7,
                  ),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8EED6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Recommendation item",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // =================== QUICK QUEST =======================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Quick quest",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 15),

            Column(
              children: List.generate(quests.length, (index) {
                final quest = quests[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 7,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8EED6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TITLE + XP
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quest["title"].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "+${quest["xp"]} Xp",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      // BUTTON
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          backgroundColor: const Color(0xFFF0AB4C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Start",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
