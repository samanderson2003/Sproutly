import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 1. Import flutter_dotenv
import 'package:nursery/screens/splash_screen.dart';

// 2. Make the main function async to await dotenv loading
Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Load the environment variables from the .env file
  await dotenv.load(fileName: ".env");

  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sproutly',
      // 4. Updated to a modern, ColorScheme-based theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D5016), // Use your app's primary green
          background: const Color(0xFFF8F6F0), // Match your background color
        ),
        useMaterial3: true, // Opt-in to Material 3
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
