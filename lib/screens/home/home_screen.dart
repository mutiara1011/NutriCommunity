import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8E3),

      // =======================================================
      // BOTTOM NAVIGATION BAR
      // =======================================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home, size: 30, color: Color(0xFF2E7D32)),
            Icon(Icons.circle_outlined, size: 30, color: Colors.grey),
            Icon(Icons.notifications_none, size: 30, color: Colors.grey),
            Icon(Icons.person_outline, size: 30, color: Colors.grey),
          ],
        ),
      ),

      // =======================================================
      // BODY
      // =======================================================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =======================================================
            // HEADER HIJAU (HI, MUTIARA + ICON PROFILE)
            // =======================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi, Mutiara",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Profile Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =======================================================
            // STREAK + XP CARD
            // =======================================================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Streak Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Streak",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "5 days",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 12),

                      // Progress bar
                      SizedBox(
                        width: w * 0.32,
                        child: const LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Color(0xFFDADADA),
                          color: Color(0xFFFFB300),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),

                  // XP Card
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "850 xp",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =======================================================
            // TODAY’S RECOMMENDATION
            // =======================================================
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
                    color: const Color(0xFFF7EED4),
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

            // =======================================================
            // QUICK QUEST
            // =======================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Quick quest",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: List.generate(4, (index) {
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
                    color: const Color(0xFFF7EED4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quest title", style: TextStyle(fontSize: 16)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          backgroundColor: const Color(0xFFFFB300),
                          foregroundColor: Colors.black,
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

            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
