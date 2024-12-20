import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/staff/staff_screen.dart';
import 'package:home/topic/topic_screen.dart';

import '../constants/size_constants.dart';

class AfterFilter extends StatefulWidget {
  final Map<String, dynamic> filters;

  const AfterFilter({Key? key, required this.filters}) : super(key: key);

  @override
  _AfterFilterState createState() => _AfterFilterState();
}

class _AfterFilterState extends State<AfterFilter> {
  int _selectedIndex = 0;

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
              fontSize: 20,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 15),
            Expanded(
              child: _buildDataTable(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Nhập từ khóa',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 19,
                fontWeight: FontWeight.normal,
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFFEBEBEB), // Màu viền
                  width: 0.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        marginW10,
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xFFCDE7FF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Icon(
              Icons.tune,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    final data = _getData(); // Lấy dữ liệu mẫu

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        columns: [
          DataColumn(
            label: Container(
              width: 40, // Có thể điều chỉnh kích thước của cột
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TT',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              width: 100, // Có thể điều chỉnh kích thước của cột
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mã số',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              width: 110, // Có thể điều chỉnh kích thước của cột
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cấp quản lý',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              width: 80, // Có thể điều chỉnh kích thước của cột
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Loại hình',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            ),
          ),
        ],
        rows: List.generate(
          data.length,
              (index) {
            final row = data[index];
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    width: 20, // Đảm bảo kích thước của ô dữ liệu
                    child: Align(
                      child: Center(child: Text('${index + 1}')), // Số thứ tự từ 1
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: 100, // Đảm bảo kích thước của ô dữ liệu
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(row['Mã số'] ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: 110, // Đảm bảo kích thước của ô dữ liệu
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(row['Cấp quản lý'] ?? ''),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: 90, // Đảm bảo kích thước của ô dữ liệu
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(row['Loại hình'] ?? ''),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Map<String, String>> _getData() {
    return [
      {'TT': '1', 'Mã số': 'MS001', 'Cấp quản lý': 'Cấp học viện', 'Loại hình': 'Tờ trình'},
      {'TT': '2', 'Mã số': 'MS002', 'Cấp quản lý': 'Cấp học viện', 'Loại hình': 'Đề tài'},
      {'TT': '3', 'Mã số': 'MS003', 'Cấp quản lý': 'Cấp học viện', 'Loại hình': 'Tờ trình'},
      {'TT': '4', 'Mã số': 'MS004', 'Cấp quản lý': 'Cấp học viện', 'Loại hình': 'Nhiệm vụ'},
      // Thêm dữ liệu mẫu nếu cần
    ];
  }
}
