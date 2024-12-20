import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/constants/size_constants.dart';
import 'package:home/topic/topic_screen.dart';
import 'package:home/staff/staff_screen.dart';
import 'package:home/setting/setting_screen.dart';

import '../report/report_screen.dart';
import 'home_screen.dart';

// StreamController to notify unauthorized access
final StreamController<bool> progressStream =
    StreamController<bool>.broadcast();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with BaseLoadingState {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // List of widget constructors
  final List<Widget> _pages = [
    const HomePage(),
    const ReportScreen(),
    const TopicScreen(),
    const StaffScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) async{
    if (_selectedIndex == index) {
      return; // Prevent reloading the same tab
    }

    setState(() {
      _selectedIndex = index;
    });

    // Navigate the page view programmatically
    // _pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 200),
    //   curve: Curves.easeInOut,
    // );
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    progressStream.stream.distinct().listen((isLoading) {
      print("progressStream event received! $isLoading");
      if (isLoading) {
        showLoading();
        return;
      }
      hideLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          physics: const NeverScrollableScrollPhysics(),
          // Prevent swipe gestures
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          itemBuilder: (context, index) {
            // Dynamically build pages using the constructor list
            return _pages[index];
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedFontSize: 10,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            _buildBottomNavigationBarItem(
                'assets/images/home.png', 'Tổng quan', 0),
            _buildBottomNavigationBarItem(
                'assets/images/totrinh.png', 'Tờ trình', 1),
            _buildBottomNavigationBarItem(
                'assets/images/detai.png', 'Đề tài', 2),
            _buildBottomNavigationBarItem(
                'assets/images/nhansu.png', 'Nhân sự', 3),
            _buildBottomNavigationBarItem(
                'assets/images/caidat.png', 'Cài đặt', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String imagePath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            color: _selectedIndex == index ? Colors.blueAccent : Colors.grey,
            width: 24,
            height: 24,
          ),
          marginH4
        ],
      ),
      label: label,
    );
  }
}
