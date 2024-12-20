import 'package:flutter/material.dart';


class ReportFilterScreen extends StatefulWidget {
  final void Function(Map<String, dynamic> filters) onApplyFilter;

  const ReportFilterScreen({Key? key, required this.onApplyFilter}) : super(key: key);

  @override
  _ReportFilterScreenState createState() => _ReportFilterScreenState();
}

class _ReportFilterScreenState extends State<ReportFilterScreen> {
  String _selectedSortOption = 'Chọn';
  String _selectedStatus = 'Chọn';
  String _selectedSigner = 'Chọn';

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
                            'Người ký',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Người ký', ['Đặng Hoài Bắc', 'Hoàng Hữu Hạnh', 'Phạm Vũ Minh Tú', 'Nguyễn Xuân Lộc'], (value) {
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
                            'Trạng thái',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Trạng thái', ['Đã ký', 'Chưa ký'], (value) {
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
                            'Phiên bản',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet('Phiên bản', ['Phiên bản 1', 'Phiên bản 2', 'Phiên bản 3', 'Phiên bản 4'], (value) {
                                setState(() {
                                  _selectedSortOption = value;
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
                                    _selectedSortOption,
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
                            'sort': _selectedSortOption,
                          };
                          widget.onApplyFilter(filters);
                          Navigator.pop(context);
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
