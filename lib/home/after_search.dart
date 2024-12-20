import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/home/search_error.dart';
import 'package:home/home/home_filter.dart';

import '../constants/size_constants.dart';

class AfterSearch extends StatefulWidget {
  const AfterSearch({Key? key, required this.searchResults}) : super(key: key);

  final List<String> searchResults;

  @override
  _AfterSearchState createState() => _AfterSearchState();
}

class _AfterSearchState extends State<AfterSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
  }

  void _performSearch() {
    setState(() {
      if (_searchController.text.isNotEmpty) {
        List<String> filteredResults = widget.searchResults
            .where((result) => result
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
        if (filteredResults.isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SearchError(),
            ),
          );
        } else {
          // Update the state with filtered results if needed
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
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
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
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
                              borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0), // Viền xanh khi không có focus
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0), // Viền xanh khi có focus
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
                              side: BorderSide(color: Color(0xFFEBEBEB), width: 1.0), // Viền xanh
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
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 90.0), // Thay đổi chiều dài của đường line
                    ),
                    tabs: [
                      Tab(text: 'Tờ trình'),
                      Tab(text: 'Đề tài'),
                      Tab(text: 'Nhân sự'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Nội dung của Tab đầu tiên là bảng
                    Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20.0,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: 20, // Điều chỉnh chiều rộng của cột 'TT'
                              child: Text(
                                'TT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, // Cỡ chữ
                                  fontWeight: FontWeight.bold, // Chữ đậm
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 100, // Điều chỉnh chiều rộng của cột 'Số tờ trình'
                              child: Text(
                                'Số tờ trình',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, // Cỡ chữ
                                  fontWeight: FontWeight.bold, // Chữ đậm
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 100, // Điều chỉnh chiều rộng của cột 'Người ký'
                              child: Text(
                                'Người ký',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, // Cỡ chữ
                                  fontWeight: FontWeight.bold, // Chữ đậm
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 90, // Điều chỉnh chiều rộng của cột 'Trạng thái'
                              child: Text(
                                'Trạng thái',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, // Cỡ chữ
                                  fontWeight: FontWeight.bold, // Chữ đậm
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Container(
                              width: 20,
                              child: Text('1', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 100,
                              child: Text('Tờ trình 001', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 110,
                              child: Text('Người ký 1', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 80,
                              height: 30, // Đảm bảo chiều cao và chiều rộng bằng nhau
                              decoration: BoxDecoration(
                                color: Colors.green[100], // Màu nền xanh nhạt
                                borderRadius: BorderRadius.circular(30.0), // Bo góc
                              ),
                              child: Center(
                                child: Text(
                                  'Đã ký',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Container(
                              width: 20,
                              child: Text('2', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 100,
                              child: Text('Tờ trình 002', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 110,
                              child: Text('Người ký 2', textAlign: TextAlign.center),
                            )),
                            DataCell(Container(
                              width: 80,
                              height: 30, // Đảm bảo chiều cao và chiều rộng bằng nhau
                              decoration: BoxDecoration(
                                color: Colors.red[100], // Màu nền đỏ nhạt
                                borderRadius: BorderRadius.circular(30.0), // Bo góc
                              ),
                              child: Center(
                                child: Text(
                                  'Chưa ký',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                          ]),
                          // Thêm các hàng khác nếu cần
                        ],
                      ),
                    ),
                  ),
                // Nội dung của Tab thứ hai
                        Center(child: Text('Nội dung 2')),
                        // Nội dung của Tab thứ ba
                        Center(child: Text('Nội dung 3')),
                      ],
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
