import 'package:flutter/material.dart';
import 'package:home/document_viewer_page.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/splash/splash_screen.dart';

import 'authentication/login_screen.dart';
import 'base/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Listen for unauthorized events
    unauthorizedStream.stream.distinct().listen((_) {
      print("Unauthorized event received!");
      // Navigate to Login Screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Clear all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        fontFamily: 'AvertaStdCy',
        // colorScheme: ColorScheme.dark(
        //   primary: Colors.blue,
        // ),
      ),
      home: const SplashScreen(),
    );
  }
}