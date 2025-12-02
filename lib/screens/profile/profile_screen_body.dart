import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';
import '../../main.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  Future<Map<String, dynamic>> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) return {};

    final res = await http.get(
      Uri.parse("$baseUrl/user_profile"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["data"];
    } else {
      return {};
    }
  }

  Future<int> fetchRank() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return -1;

    final res = await http.get(
      Uri.parse("$baseUrl/rank_me"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body["data"]["rank"] ?? -1;
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([fetchProfile(), fetchRank()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.hasError) {
              return const Center(child: Text("Failed to load profile"));
            }

            final profile = snapshot.data![0] as Map<String, dynamic>;
            final rank = snapshot.data![1] as int;

            final username = profile["username"] ?? "User";
            final level = profile["level"] ?? 1;
            final expToNext = profile["expToNext"] ?? 100;
            final double progress = (profile["progress"] ?? 0).toDouble();
            final totalBadge = profile["totalBadge"] ?? 0;
            final totalQuest = profile["totalQuest"] ?? 0;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // PROFILE BOX
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8EED6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Level $level",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFF0AB4C),
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // XP PROGRESS
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
                        Stack(
                          children: [
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                double normalized = (progress / 10).clamp(
                                  0.0,
                                  1.0,
                                );

                                return Container(
                                  height: 12,
                                  width: 180 * normalized,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF398A57),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Next level in $expToNext XP",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // RANK
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _statCard(Icons.arrow_upward, "Highest Rank", "Top 5%"),
                        const SizedBox(width: 12),
                        _statCard(
                          Icons.emoji_events,
                          "Current Rank",
                          rank == -1 ? "N/A" : "Ranked $rank",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _statCard(
                          Icons.verified,
                          "Total Badges",
                          "$totalBadge Badges",
                        ),
                        const SizedBox(width: 12),
                        _statCard(
                          Icons.list_alt,
                          "Completed Quest",
                          "$totalQuest Quest",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Badges",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _badgeCircle(Colors.orange, Icons.star),
                        const SizedBox(width: 14),
                        _badgeCircle(Colors.orangeAccent, Icons.verified_user),
                        const SizedBox(width: 14),
                        _badgeCircle(Colors.grey, Icons.check_circle),
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
            );
          },
        ),
      ),
    );
  }

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
