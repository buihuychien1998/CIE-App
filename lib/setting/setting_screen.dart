import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/home/search_home.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/topic/topic_screen.dart';
import 'package:home/staff/staff_screen.dart';

import '../authentication/login_screen.dart';
import '../base/api_service.dart';
import '../constants/app_constants.dart';
import '../constants/secure_storage.dart';
import '../constants/size_constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 4;
  double _iconSpacing = 10.0; // Khoảng cách giữa chữ và icon
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _updateIconSpacing(double spacing) {
    setState(() {
      _iconSpacing = spacing;
    });
  }

  // void _showSettingsOverlay(BuildContext context) {
  //   Navigator.of(context).push(PageRouteBuilder(
  //     opaque: false,
  //     pageBuilder: (BuildContext context, _, __) {
  //       return Stack(
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Container(
  //               color: Colors.black12,
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: FractionallySizedBox(
  //               widthFactor: 0.8,
  //               heightFactor: 1.0,
  //               child: Container(
  //                 color: Colors.blue,
  //                 child: Column(
  //                   children: [
  //                     // thêm nội dung sau
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       final tween = Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
  //       final curvedAnimation = CurvedAnimation(
  //         parent: animation,
  //         curve: Curves.easeInOut,
  //       );
  //       return SlideTransition(
  //         position: tween.animate(curvedAnimation),
  //         child: child,
  //       );
  //     },
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: const BoxDecoration(color: const Color(0xff4285F4)),
              accountName: Text(
                AppConstant.profile?.name ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                AppConstant.profile?.email ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.1),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/img_avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/ic_account_circle.png",
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Hồ sơ',
                style: TextStyle(color: Color(0xFF454545), fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/ic_individual.png",
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Thông tin cá nhân',
                style: TextStyle(color: Color(0xFF454545), fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/ic_lock.png",
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Mật khẩu và bảo mật',
                style: TextStyle(color: Color(0xFF454545), fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/ic_help.png",
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Hỗ trợ',
                style: TextStyle(color: Color(0xFF454545), fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/ic_logout.png",
                height: 24,
                width: 24,
              ),
              title: const Text(
                'Đăng xuất',
                style: TextStyle(color: Color(0xFF454545), fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(_scaffoldKey.currentContext!);
                // Clear stored tokens or credentials
                AppConstant.profile = null;
                setToken(null);

                // Navigate to login screen
                Navigator.pushAndRemoveUntil(
                  _scaffoldKey.currentContext!,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, // Clear all previous routes
                );

                // // Broadcast the unauthorized event
                // unauthorizedStream.add(null);
              },
            ),
          ],
        ),
      ),
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
                    // _showSettingsOverlay(context);
                    _scaffoldKey.currentState
                        ?.openEndDrawer(); //This might have been updated by flutter team since the last edit
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
