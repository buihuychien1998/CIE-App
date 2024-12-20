import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/home/search_home.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/topic/topic_screen.dart';
import 'package:home/staff/staff_screen.dart';

import '../constants/size_constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 4;
  double _iconSpacing = 10.0; // Khoảng cách giữa chữ và icon

  void _updateIconSpacing(double spacing) {
    setState(() {
      _iconSpacing = spacing;
    });
  }

  void _showSettingsOverlay(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.black12,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 1.0,
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      // thêm nội dung sau
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Align(
            alignment: Alignment(0, -0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                ),
                const Text(
                  'Cài đặt phân quyền',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    _showSettingsOverlay(context);
                  },
                  child: Image.asset(
                    'assets/images/caidat.png',
                    width: 24, // Cỡ ảnh
                    height: 24, // Cỡ ảnh
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 7.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchHome(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Color(0xFFEBEBEB),
                                    // Thêm viền màu xanh
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.grey),
                                    marginW10,
                                    Text(
                                      'Nhập từ khoá',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          marginW10,
                          OutlinedButton(
                            onPressed: () {
                              // Thêm  điều hướng
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: Color(0xFFEBEBEB),
                                width: 1.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              minimumSize: const Size(50, 50),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
