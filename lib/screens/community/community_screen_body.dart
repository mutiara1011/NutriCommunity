import 'package:flutter/material.dart';
import 'tabs/rank_tab.dart';
import 'tabs/post_tab.dart';
import 'tabs/event_tab.dart';

class CommunityScreenBody extends StatelessWidget {
  const CommunityScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const SizedBox(height: 40),

          // HEADER HIJAU
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            decoration: const BoxDecoration(color: Color(0xFF398A57)),
            child: Row(
              children: [
                const Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9F4E7),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // CUSTOM TAB BAR SESUAI DESAIN
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFEFE5CA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: const Color(0xFFFFB300),
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Rank"),
                Tab(text: "Post"),
                Tab(text: "Events"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: TabBarView(
              children: const [RankTab(), PostTab(), EventTab()],
            ),
          ),
        ],
      ),
    );
  }
}
