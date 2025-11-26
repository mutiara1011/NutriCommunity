import 'package:flutter/material.dart';
import 'screens/history/history_screen_body.dart';
import 'screens/home/home_screen_body.dart';
import 'screens/community/community_screen_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreenBody(),
    const CommunityScreenBody(),
    const HistoryScreenBody(),
    const Center(child: Text("Settings Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
          color: Color(0xFFFFFBEA),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 0),
              child: Icon(
                Icons.home,
                size: 40,
                color: selectedIndex == 0
                    ? Color(0xFF398A57)
                    : Color(0xFFA4A48F),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 1),
              child: Icon(
                Icons.bar_chart,
                size: 40,
                color: selectedIndex == 1
                    ? Color(0xFF398A57)
                    : Color(0xFFA4A48F),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 2),
              child: Icon(
                Icons.access_time,
                size: 40,
                color: selectedIndex == 2
                    ? Color(0xFF398A57)
                    : Color(0xFFA4A48F),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 3),
              child: Icon(
                Icons.account_circle_outlined,
                size: 40,
                color: selectedIndex == 3
                    ? Color(0xFF398A57)
                    : Color(0xFFA4A48F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
