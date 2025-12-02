import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class HistoryScreenBody extends StatefulWidget {
  final bool showBackButton;

  const HistoryScreenBody({super.key, this.showBackButton = false});

  @override
  State<HistoryScreenBody> createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  List<Map<String, dynamic>> questHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCompletedQuest();
  }

  Future<void> fetchCompletedQuest() async {
    final token = globalToken; // <-- AMBIL DARI MAIN.DART
    if (token == null) {
      print("TOKEN NULL");
      setState(() => isLoading = false);
      return;
    }

    final url = Uri.parse("$baseUrl/quest/me");

    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      print("RESPONSE QUEST/ME: ${response.body}");
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List rawList = json["data"];

        // Ambil nama quest satu per satu
        for (var item in rawList) {
          String questId = item["quest_id"];
          String questName = await fetchQuestName(questId);

          questHistory.add({
            "title": questName,
            "status": "Completed",
            "xp": item["exp_earned"],
            "completed_at": item["completed_at"],
          });
        }
      }

      setState(() => isLoading = false);
    } catch (e) {
      print("ERROR FETCH QUEST/ME: $e");
      setState(() => isLoading = false);
    }
  }

  Future<String> fetchQuestName(String id) async {
    final url = Uri.parse("$baseUrl/quest/$id");

    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return json["data"]["title"] ?? "Unknown Quest";
      }
    } catch (e) {
      print("ERR FETCH QUEST NAME: $e");
    }

    return "Unknown Quest";
  }

  String formatTimeAgo(String isoTime) {
    final time = DateTime.parse(isoTime).toLocal();
    final diff = DateTime.now().difference(time);

    if (diff.inMinutes < 60) return "${diff.inMinutes} minutes ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    return "${diff.inDays} days ago";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showBackButton)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 28),
                ),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                "History",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: questHistory.length,
                      itemBuilder: (context, index) {
                        final item = questHistory[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
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
                              // LEFT SIDE
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["title"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        "Completed",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // RIGHT SIDE
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "+${item["xp"]} Xp",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2F7F3F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTimeAgo(item["completed_at"]),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
