import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../community/community_screen_body.dart';

import '../quest/camera_screen.dart';
import 'education_detail_screen.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  List quests = [];
  List articles = [];
  String username = "User";
  int streak = 0;
  int xp = 0;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    fetchProfile();
    fetchQuests();
    fetchArticles();
  }

  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) return;

    final res = await http.get(
      Uri.parse("$baseUrl/user_profile"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)["data"];
      setState(() {
        username = data["username"] ?? "User";
        streak = data["streak"] ?? 0;
        xp = data["exp"] ?? 0;
        progress = data["progress"] ?? 10;
      });
    }
  }

  Future<void> fetchQuests() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.get(
      Uri.parse("$baseUrl/quest"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        quests = data["data"] ?? [];
      });
    }
  }

  Future<void> fetchArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.get(
      Uri.parse("$baseUrl/article"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        articles = data["data"] ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 28,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(color: Color(0xFF398A57)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Hi, $username",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF9F4E7),
                      ),
                      overflow: TextOverflow.ellipsis,
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

            // STREAK & XP
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(color: Color(0xFFFFFBEA)),
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
                      Text(
                        "$streak days",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Builder(
                        builder: (context) {
                          // progress dari API 1–10 → ubah ke 0.0–1.0
                          double normalized = (progress / 10).clamp(0.0, 1.0);

                          return Stack(
                            children: [
                              Container(
                                width: 140,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                width: 140 * normalized,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF398A57),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0AB4C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$xp Xp",
                      style: const TextStyle(
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

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today's recommendations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 15),

            ...articles.map((item) {
              final imageUrl = "$baseUrl/images/articles/${item['image']}";
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EducationDetailScreen(
                        title: item["title"] ?? "",
                        paragraph1: item["first"] ?? "",
                        paragraph2: item["second"] ?? "",
                        paragraph3: item["third"],
                        imageUrl: imageUrl,
                        articleId: item["_id"],
                      ),
                    ),
                  );
                },
                child: Container(
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
                    children: [
                      Expanded(
                        child: Text(
                          item["title"] ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Quick quest",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 15),

            ...quests.map((quest) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quest["title"] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "+${quest["xp_reward"] ?? 0} Xp",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (quest["type"] == "food") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CameraScreen(
                                questId: quest["_id"],
                                questTitle: quest["title"] ?? "",
                                xp: quest["xp_reward"] ?? 0,
                              ),
                            ),
                          );
                        } else if (quest["type"] == "post") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CommunityScreenBody(),
                            ),
                          );
                        }
                      },
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
            }).toList(),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
