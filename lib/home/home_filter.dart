import 'package:flutter/material.dart';
import 'package:home/home/after_filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeFilter(),
    );
  }
}

class HomeFilter extends StatefulWidget {
  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  String _selectedStatus = 'Chọn';
  String _selectedSigner = 'Chọn';
  String _selectedVersion = 'Chọn';

  void _showBottomSheet(String title, List<String> options, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 2 / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8,),
              Positioned(
              bottom: 20,
              child: Container(
                width: 60,
                height: 3,
                color: Colors.grey,
              ),
            ),
              SizedBox(height: 10,),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
                Divider(),
                ...options.map((String value) {
                  return ListTile(
                    title: Text(value),
                    onTap: () {
                      onSelected(value);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 100.0),
          child: Text(
            'Bộ lọc',
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Năm thực hiện',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Năm thực hiện', ['2020', '2021', '2022', '2023', '2024'], (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedStatus,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Loại hình',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Chọn loại hình', ['Tờ trình', 'Đề tài', 'Nhiệm Vụ'], (value) {
                                setState(() {
                                  _selectedSigner = value;
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedSigner,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Phiên bản',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Chọn phiên bản', ['Phiên bản 01', 'Phiên bản 02', 'Phiên bản 03', 'Phiên bản 04', 'Phiên bản 05'], (value) {
                                setState(() {
                                  _selectedVersion = value;
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedVersion,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 35),
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> filters = {
                            'status': _selectedStatus,
                            'signer': _selectedSigner,
                            'version': _selectedVersion,
                          };
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfterFilter(filters:{
                                'Loại hình': 'Tờ trình',
                                'Loại hình': 'Đề tài',
                                'Loại hình': 'Nhiệm vụ',
                              }),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(double.infinity, 45),
                        ),
                        child: const Text('Áp dụng', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
