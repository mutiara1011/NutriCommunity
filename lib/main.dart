import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'main_screen.dart';
import 'screens/history/history_screen_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<CameraDescription> cameras;

String? globalToken;
const String baseUrl = "https://devlabfortirta.cloud/api-nutricom";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  globalToken = prefs.getString('token');

  cameras = await availableCameras();
  runApp(const NutriCommunityApp());
}

class NutriCommunityApp extends StatelessWidget {
  const NutriCommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: globalToken == null || globalToken!.isEmpty ? '/' : '/main',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
        '/history': (context) => const HistoryScreenBody(),
      },
    );
  }
}
