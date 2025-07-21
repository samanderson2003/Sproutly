import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nursery/screens/splash_screen.dart';
import 'package:nursery/screens/login_screen.dart'; // 1. Import Login Screen
import 'package:nursery/screens/signup_screen.dart'; // 2. Import Signup Screen
import 'package:nursery/screens/main_screen.dart'; // 3. Import Main Screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // The app starts with the SplashScreen
      home: const SplashScreen(),
      // 4. Define all the navigation routes for your app
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
