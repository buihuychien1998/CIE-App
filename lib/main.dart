import 'package:flutter/material.dart';
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
  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Listen for unauthorized events
    unauthorizedStream.stream.distinct().listen((_) {
      print("Unauthorized event received!");
      // Navigate to Login Screen
      _navKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Clear all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
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
