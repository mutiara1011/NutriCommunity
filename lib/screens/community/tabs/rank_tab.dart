import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../main.dart';

class RankTab extends StatelessWidget {
  const RankTab({super.key});

  Future<List<Map<String, dynamic>>> fetchRanks() async {
    final res = await http.get(Uri.parse("$baseUrl/user_rank"));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)["data"] as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to fetch ranks");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchRanks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No ranking data"));
          }

          final ranks = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ranks.length,
            itemBuilder: (context, index) {
              final rank = ranks[index]["rank"];
              final username = ranks[index]["username"];
              final exp = ranks[index]["exp"];
              final avatar = ranks[index]["avatar"];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EED6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LEFT SIDE (RANK ICON + NAME)
                    Row(
                      children: [
                        rank <= 3
                            ? Image.asset("assets/rank/$rank.png", height: 36)
                            : Text(
                                rank.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(width: 14),
                        // Avatar + Name
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFF2F7F3F),
                              backgroundImage: avatar != null
                                  ? NetworkImage(
                                      "$baseUrl/images/avatars/$avatar",
                                    )
                                  : null,
                              child: avatar == null
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              username ?? "User",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // XP
                    Text(
                      exp.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
