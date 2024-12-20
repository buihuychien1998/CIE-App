import 'package:flutter/material.dart';
import 'package:home/constants/secure_storage.dart';

import '../authentication/login_screen.dart';
import '../home/dashboard_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login screen after 3 seconds
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      String token = await getToken(); // Get token from secure storage
      print("splash token");
      print("$token");
      if (token.isEmpty) {
        // If token is empty, navigate to login screen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        // If token exists, navigate to the home screen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      }
    } catch (e, stackTrace) {
      // Handle error (e.g., token retrieval failed)
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigate to login in case of an error
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back button on splash screen
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Image.asset(
          'assets/images/logoSplash.png',
          fit: BoxFit.contain,
          width: 240, // Điều chỉnh kích thước ảnh theo ý muốn
          height: 90, // Điều chỉnh kích thước ảnh theo ý muốn
        ),
      ),
    );
  }

}
