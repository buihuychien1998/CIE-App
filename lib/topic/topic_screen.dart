import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/search/filter_screen.dart';
import 'package:home/search/search_screen.dart';
import 'package:home/models/topic_response.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/topic/topic_detail_screen.dart';
import 'package:home/topic/topic_create_screen.dart';
import 'package:home/staff/staff_screen.dart';

import '../base/api_url.dart';
import '../base/base_loading_state.dart';
import '../constants/app_constants.dart';
import '../constants/size_constants.dart';
import '../utils/toast_utils.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key});

  @override
  TopicScreenState createState() => TopicScreenState();
}

class TopicScreenState extends State<TopicScreen> with BaseLoadingState {
  List<Topic>? _rows;
  List<Topic>? _filteredRows;
  int? _expandedRowIndex;

  @override
  void initState() {
    super.initState();
    getAllTopic();
    _filteredRows = _rows;
  }


  void _navigateToTopicDetailPage(BuildContext context, Topic? topic) async{
    if (topic == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicDetailScreen(
          topic: topic,
        ),
      ),
    );
    getAllTopic();
  }

  void _showDeleteTopicConfirmationSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red[100],
                  ),
                  child: Icon(
                    Icons.warning_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Xóa đề tài này?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 12),
              const Text(
                'Nếu xóa để tài này, bạn sẽ không thể khôi phục lại nữa. Bạn có chắc chắn muốn tiếp tục xóa không?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF626262), fontSize: 12),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      deleteTopic(_filteredRows?[index].topicCode);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Xóa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToFilterPage(BuildContext context) async {
    final filters = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(
          onApplyFilter: (filters) {
            setState(() {
              _filteredRows = _rows?.where((row) {
                //   bool matchesStatus = filters['status'] == '' || row.contains(filters['status']!);
                //   bool matchesSigner = filters['signer'] == '' || row.contains(filters['signer']!);
                //   return matchesStatus && matchesSigner;
                return true;
              }).toList();
            });
          }, type: SearchType.topic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Align(
              alignment: Alignment(0, -0.85),
              child: const Text(
                'Quản lý đề tài',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
                                      builder: (context) => SearchScreen(type: SearchType.topic),
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
                                _navigateToFilterPage(context);
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFFEBEBEB), // Thêm viền màu xanh
                                  width: 1.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                minimumSize: const Size(50, 50),
                                padding: EdgeInsets.zero, // Remove padding
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
                          child: _filteredRows == null ? const SizedBox() :  SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 24.0,
                              horizontalMargin: 0,
                              columns: const [
                                DataColumn(
                                    label: Padding(
                                      padding:
                                      EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'TT',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                DataColumn(
                                    label: Text('Mã số',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                                DataColumn(
                                    label: Text('Cấp quản lý',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                                DataColumn(
                                    label: Text('Loại hình',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                                DataColumn(label: Text('')),
                              ],
                              rows: List.generate(_filteredRows?.length ?? 0,
                                  (index) {
                                final isExpanded = _expandedRowIndex == index;
                                Topic? topic = _filteredRows?[index];
                                return DataRow(
                                  cells: [
                                    DataCell(Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF121212),
                                          ),
                                        ),
                                      ),
                                    )),
                                    DataCell(Text(
                                      topic?.topicCode ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF121212),
                                      ),
                                    )),
                                    DataCell(Text(
                                      topic?.levelManager ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF121212),
                                      ),
                                    )),
                                    DataCell(Text(
                                      topic?.unit ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF121212),
                                      ),
                                    )),
                                    DataCell(
                                      Row(
                                        children: [
                                          Container(
                                            width: 54,
                                            height: 54,
                                            margin: const EdgeInsets.only(top: 1),
                                            color: const Color(0xFF4285F4),
                                            child: GestureDetector(
                                              onTap: () {
                                                _navigateToTopicDetailPage(context,
                                                    _filteredRows?[index]);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/ic_edit.png",
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                  const Flexible(
                                                    child: Text(
                                                      'Sửa',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 54,
                                            height: 54,
                                            margin: const EdgeInsets.only(top: 1),
                                            color: const Color(0xFFFC4D4D),
                                            child: GestureDetector(
                                              onTap: () {
                                                _showDeleteTopicConfirmationSheet(
                                                    context, index);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/ic_trash.png",
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                  const Flexible(
                                                    child: Text(
                                                      'Xoá',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: () async{
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicCreateScreen(),
                ),
              );
              if (result) {
                getAllTopic();
              }
            },
            child: const Icon(
              Icons.add_outlined,
              color: Colors.white,
              size: 40,
            ),
            backgroundColor: Colors.blueAccent,
            shape: const CircleBorder(),
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  Future<void> getAllTopic() async {
    progressStream.add(true);
    
    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_topic(),
      );

      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        _rows = response.topic ?? [];
        _filteredRows = response.topic ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }

  Future<void> deleteTopic(String? code) async {
    progressStream.add(true);
    // Lấy dữ liệu từ form
    try {
      final body = {
        "topic_code": code
      };
      await apiService.post(ApiUrl.post_delete_topic(), body: body);
      final data = await apiService.get(
        ApiUrl.get_all_topic(),
      );

      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        _rows = response.topic ?? [];
        _filteredRows = response.topic ?? [];
      });
      ToastUtils.showSuccess("Bạn đã xoá đề tài thành công!");
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }
}
