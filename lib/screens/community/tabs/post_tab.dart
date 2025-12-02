import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  List<dynamic> posts = [];
  bool isLoading = true;
  bool isError = false;

  // ================================================================
  // FORMAT TANGGAL KE WIB → "20 September 2025 13.27"
  // ================================================================
  String formatTanggalWIB(String isoTime) {
    try {
      DateTime utc = DateTime.parse(isoTime).toUtc();
      DateTime wib = utc.add(const Duration(hours: 7));

      const bulan = [
        "Januari",
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember",
      ];

      String hari = wib.day.toString();
      String namaBulan = bulan[wib.month - 1];
      String tahun = wib.year.toString();

      String jam = wib.hour.toString().padLeft(2, '0');
      String menit = wib.minute.toString().padLeft(2, '0');

      return "$hari $namaBulan $tahun $jam.$menit";
    } catch (e) {
      return isoTime;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final url = Uri.parse("$baseUrl/post");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        setState(() {
          posts = decoded["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print("ERROR: $e");
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
          ? const Center(child: Text("Gagal memuat postingan"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                final user = post["user"];
                final username = user?["username"] ?? "Unknown";

                final caption = post["description"] ?? "";
                final imageName = post["image"] ?? "";
                final createdAt = post["createdAt"] ?? "";

                final formattedDate = formatTanggalWIB(createdAt);
                final imageUrl = "$baseUrl/images/posts/$imageName";

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7EED4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF2F7F3F),
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(caption, style: const TextStyle(fontSize: 14)),

                      const SizedBox(height: 12),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              height: 180,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, err, stack) {
                            return Container(
                              height: 150,
                              color: Colors.grey.shade300,
                              alignment: Alignment.center,
                              child: const Text("Gambar tidak tersedia"),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: const [
                          Icon(Icons.thumb_up_alt_outlined, size: 22),
                          SizedBox(width: 12),
                          Icon(Icons.mode_comment_outlined, size: 22),
                          SizedBox(width: 12),
                          Icon(Icons.share_outlined, size: 22),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
