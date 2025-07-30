import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Ensure this is imported
import 'package:nursery/providers/cart_provider.dart'; // Ensure this is imported

// Your screen imports
import 'package:nursery/screens/splash_screen.dart';
import 'package:nursery/screens/login_screen.dart';
import 'package:nursery/screens/signup_screen.dart';
import 'package:nursery/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This wrapper makes the CartProvider available to your entire app
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Your existing routes and home screen remain the same
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}
