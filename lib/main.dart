import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/diary_list_screen.dart';
import 'screens/add_diary_screen.dart';

void main() async {
  // logic to initialize Firebase will go here later
  runApp(const CloudyLogApp());
}

class CloudyLogApp extends StatelessWidget {
  const CloudyLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CloudyLog',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Define our navigation routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/diary_list': (context) => const DiaryListScreen(),
        '/add_diary': (context) => const AddDiaryScreen(),
      },
    );
  }
}
