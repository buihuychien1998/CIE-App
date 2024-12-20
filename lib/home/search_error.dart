import 'package:flutter/material.dart';
import 'package:home/home/after_search.dart';
import 'package:home/home/home_filter.dart';
import 'package:home/home/dashboard_screen.dart';

import '../constants/size_constants.dart';

class SearchError extends StatefulWidget {
  const SearchError({Key? key}) : super(key: key);

  @override
  _SearchErrorState createState() => _SearchErrorState();
}

class _SearchErrorState extends State<SearchError> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  List<String> _allResults = [
    'Tờ trình',
    'Đề tài',
    'Nhân sự',
    'Báo cáo',
  ];

  void _performSearch() {
    setState(() {
      _searchResults.clear();
      if (_searchController.text.isNotEmpty) {
        _searchResults = _allResults
            .where((result) => result
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
        if (_searchResults.isEmpty) {
          // Hiển thị thông báo lỗi và giữ trang hiện tại
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AfterSearch(
                searchResults: _searchResults,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 90.0),
          child: Text(
            'Tìm kiếm',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _performSearch(),
                    decoration: InputDecoration(
                      hintText: 'Nhập từ khóa',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                marginW10,
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        _performSearch();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeFilter(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(-10, 0),
                            child: const Icon(Icons.tune, color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Không tìm thấy kết quả tìm kiếm',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 70,
                    left: 50,
                    child: Image.asset(
                      'assets/images/search_error.png',
                      width: 282,
                      height: 180,
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 90,
                    child: Text(
                      'Hãy thử lại với từ khóa khác',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
