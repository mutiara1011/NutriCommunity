import 'dart:io';

class QuestService {
  static int xp = 850;

  static List<Map<String, dynamic>> history = [];
  static List<Map<String, dynamic>> posts = [];

  // tambah XP
  static void addXp(int amount) {
    xp += amount;
  }

  // simpan history
  static void addHistory(String title, bool completed, int? xp) {
    history.add({
      "title": title,
      "status": completed ? "Completed" : "Failed",
      "xp": xp,
      "time": DateTime.now(),
    });
  }

  // simpan postingan
  static void addPost(String caption, File image) {
    posts.add({
      "caption": caption,
      "image": image,
      "time": DateTime.now(),
      "username": "mutiaraas",
      "location": "Serang",
    });
  }
}
