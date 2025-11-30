import 'package:flutter/material.dart';
import 'tabs/rank_tab.dart';
import 'tabs/post_tab.dart';
import 'tabs/event_tab.dart';

class CommunityScreenBody extends StatelessWidget {
  const CommunityScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // <--- Tambahkan Scaffold
      backgroundColor: const Color(0xFFFFFBEA),
      body: DefaultTabController(
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
                children: const [
                  Text(
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
            // TAB BAR
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF398A57),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(color: const Color(0xFFFFFBEA)),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: const Color(0xFFF0AB4C),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
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
            ),
            Expanded(
              child: TabBarView(
                children: const [RankTab(), PostTab(), EventTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
