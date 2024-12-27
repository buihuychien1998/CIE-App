import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/search/filter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/api_url.dart';
import '../constants/app_constants.dart';
import '../constants/secure_storage.dart';
import '../constants/size_constants.dart';
import '../extension/string_extension.dart';
import '../models/employee_response.dart';
import '../models/proposal_response.dart';
import '../models/topic_response.dart';
import '../report/report_detail_screen.dart';
import '../staff/staff_detail_screen.dart';
import '../topic/topic_detail_screen.dart';
import '../utils/toast_utils.dart';

class SearchResultScreen extends StatefulWidget {
  final SearchType type;
  final String query;

  const SearchResultScreen(
      {super.key, required this.type, required this.query});

  @override
  SearchResultScreenState createState() => SearchResultScreenState();
}

class SearchResultScreenState extends State<SearchResultScreen>
    with BaseLoadingState {
  final TextEditingController _searchController = TextEditingController();
  List<Proposal> proposals = [];
  List<Topic> topics = [];
  List<Employee> staff = [];
  List<Proposal>? filterProposals;
  List<Topic>? filterTopics;
  List<Employee>? filterStaff;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    _fetchAllData();
  }

  void _performSearch() {
    setState(() {
      _applyFilters({});
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 4.0, left: 90.0),
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
              icon: const Icon(Icons.arrow_back),
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
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (_) => _performSearch(),
                        decoration: InputDecoration(
                          hintText: 'Nhập từ khóa',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFEBEBEB), width: 1.0),
                            // Viền xanh khi không có focus
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFEBEBEB), width: 1.0),
                            // Viền xanh khi có focus
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 11.0, horizontal: 10.0),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                    marginW10,
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            _performSearch();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilterScreen(
                                  onApplyFilter: (filters) {
                                    setState(() {
                                      _applyFilters(filters);
                                    });
                                  },
                                  type: widget.type,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFFEBEBEB),
                              // Thêm viền màu xanh
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            minimumSize: const Size(50, 50),
                            padding: EdgeInsets.zero, // Remove padding
                          ),
                          child: const Icon(Icons.tune, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                marginH20,
                Expanded(
                  child: widget.type == SearchType.report
                      ? buildReport()
                      : widget.type == SearchType.topic
                          ? buildTopic()
                          : widget.type == SearchType.staff
                              ? buildStaff()
                              : buildAll(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReport() {
    return filterProposals == null
        ? const SizedBox.shrink()
        : filterProposals!.isEmpty
            ? buildEmptySearch()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24.0,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(
                        label: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'TT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    DataColumn(
                        label: Text('Số tờ trình',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Người ký',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Trạng thái',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(label: Text('')),
                  ],
                  rows: List.generate(filterProposals!.length, (index) {
                    Proposal? proposal = filterProposals![index];
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
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
                        DataCell(Text(
                          proposal?.proposalCode ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Text(
                          proposal?.signer ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        )),
                        DataCell(Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              color: proposal?.status == true
                                  ? const Color(0xFFEAFFEC)
                                  : const Color(0xFFFFEEEE),
                            ),
                            child: Text(
                              proposal?.status == true ? 'Đã ký' : "Chưa ký",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: proposal?.status == true
                                    ? const Color(0xFF3ED653)
                                    : const Color(0xFFFC4D4D),
                              ),
                            ))),
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
                                    _navigateToReportDetailPage(
                                        context, filterProposals?[index]);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    _showDeleteReportConfirmationSheet(
                                        context, index);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              );
  }

  Widget buildTopic() {
    return filterTopics == null
        ? const SizedBox.shrink()
        : filterTopics!.isEmpty
            ? buildEmptySearch()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24.0,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(
                        label: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'TT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    DataColumn(
                        label: Text('Mã số',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Cấp quản lý',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Loại hình',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(label: Text('')),
                  ],
                  rows: List.generate(filterTopics!.length ?? 0, (index) {
                    Topic? topic = filterTopics![index];
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
                                    _navigateToTopicDetailPage(
                                        context, filterTopics![index]);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              );
  }

  Widget buildStaff() {
    return filterStaff == null
        ? const SizedBox.shrink()
        : filterStaff!.isEmpty
            ? buildEmptySearch()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24.0,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(
                        label: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'TT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )),
                    DataColumn(
                        label: Text('Họ tên',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Mã nhân viên',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(
                        label: Text('Chức vụ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    DataColumn(label: Text('')),
                  ],
                  rows: List.generate(filterStaff?.length ?? 0, (index) {
                    Employee? employee = filterStaff?[index];

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
                          employee?.fullname ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF121212),
                          ),
                        )),
                        DataCell(Text(
                          employee?.employCode ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF121212),
                          ),
                        )),
                        DataCell(Text(
                          employee?.position ?? "",
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
                                    _navigateToStaffDetailPage(
                                        context, employee);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    _showDeleteStaffConfirmationSheet(
                                        context, index);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              );
  }

  Widget buildAll() {
    return Column(
      children: [
        const TabBar(
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
            insets: EdgeInsets.symmetric(
                horizontal: 90.0), // Thay đổi chiều dài của đường line
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
                          width: 20,
                          // Điều chỉnh chiều rộng của cột 'TT'
                          child: const Text(
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
                          width: 100,
                          // Điều chỉnh chiều rộng của cột 'Số tờ trình'
                          child: const Text(
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
                          width: 100,
                          // Điều chỉnh chiều rộng của cột 'Người ký'
                          child: const Text(
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
                          width: 90,
                          // Điều chỉnh chiều rộng của cột 'Trạng thái'
                          child: const Text(
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
                          child: const Text('1', textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 100,
                          child: const Text('Tờ trình 001',
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 110,
                          child: const Text('Người ký 1',
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 80,
                          height: 30,
                          // Đảm bảo chiều cao và chiều rộng bằng nhau
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            // Màu nền xanh nhạt
                            borderRadius: BorderRadius.circular(30.0), // Bo góc
                          ),
                          child: const Center(
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
                          child: const Text('2', textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 100,
                          child: const Text('Tờ trình 002',
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 110,
                          child: const Text('Người ký 2',
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Container(
                          width: 80,
                          height: 30,
                          // Đảm bảo chiều cao và chiều rộng bằng nhau
                          decoration: BoxDecoration(
                            color: Colors.red[100], // Màu nền đỏ nhạt
                            borderRadius: BorderRadius.circular(30.0), // Bo góc
                          ),
                          child: const Center(
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
              const Center(child: Text('Nội dung 2')),
              // Nội dung của Tab thứ ba
              const Center(child: Text('Nội dung 3')),
            ],
          ),
        ),
      ],
    );
  }

  buildEmptySearch() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24.0),
          child: const Text(
            'Không tìm thấy kết quả tìm kiếm',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
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
              const Positioned(
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
    );
  }

  Future<void> getAllProposal() async {
    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_proposal(),
      );

      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        proposals = response.proposal ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {}
  }

  Future<void> getAllTopic() async {
    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_topic(),
      );

      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        topics = response.topic ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {}
  }

  Future<void> getAllEmployee() async {
    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        staff = response.employee ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {}
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList(SEARCH_HISTORY) ?? [];
    });
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SEARCH_HISTORY, _searchHistory);
  }

  Future<void> _fetchAllData() async {
    showLoading();
    try {
      await Future.wait([
        _loadSearchHistory(),
        getAllProposal(),
        getAllTopic(),
        getAllEmployee(),
      ]);
      _performSearch();
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

  void _navigateToStaffDetailPage(BuildContext context, Employee? staff) async {
    if (staff == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StaffDetailScreen(
          staff: staff,
        ),
      ),
    );
    getAllEmployee();
  }

  void _showDeleteStaffConfirmationSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
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
                  child: const Icon(
                    Icons.warning_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Xóa nhân sự này?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nếu xóa nhân sự sự này, bạn sẽ không thể khôi phục lại nữa. Bạn có chắc chắn muốn tiếp tục xóa không?',
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
                      deleteStaff(filterStaff?[index].employCode);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
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

  Future<void> deleteStaff(String? code) async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = {"employ_code": code};
      await apiService.post(ApiUrl.post_delete_employee(), body: body);
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        staff = response.employee ?? [];
        _performSearch();
      });
      ToastUtils.showSuccess("Bạn đã xoá nhân sự thành công!");
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

  void _navigateToTopicDetailPage(BuildContext context, Topic? topic) async {
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
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
                  child: const Icon(
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
              const SizedBox(height: 12),
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
                      deleteTopic(filterTopics?[index].topicCode);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
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

  Future<void> deleteTopic(String? code) async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = {"topic_code": code};
      await apiService.post(ApiUrl.post_delete_topic(), body: body);
      final data = await apiService.get(
        ApiUrl.get_all_topic(),
      );

      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        topics = response.topic ?? [];
        _performSearch();
      });
      ToastUtils.showSuccess("Bạn đã xoá đề tài thành công!");
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

  void _navigateToReportDetailPage(
      BuildContext context, Proposal? proposal) async {
    if (proposal == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailScreen(
          proposal: proposal,
        ),
      ),
    );
    getAllProposal();
  }

  void _showDeleteReportConfirmationSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
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
                  child: const Icon(
                    Icons.warning_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Xóa tờ trình này?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nếu xóa tờ trình này, bạn sẽ không thể khôi phục lại nữa. Bạn có chắc chắn muốn tiếp tục xóa không?',
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
                      deleteProposal(filterProposals?[index].proposalCode);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
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

  Future<void> deleteProposal(String? code) async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = {"proposal_code": code};
      await apiService.post(ApiUrl.post_delete_proposal(), body: body);
      final data = await apiService.get(
        ApiUrl.get_all_proposal(),
      );

      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        proposals = response.proposal ?? [];
        filterProposals = response.proposal ?? [];
      });
      ToastUtils.showSuccess("Bạn đã xoá tờ trình thành công!");
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

  void _applyFilters(Map<String, dynamic> filters) {
    final query = _searchController.text.trim().toLowerCase();
    if (!TextUtils.isEmpty(query)) {
      _searchHistory.remove(_searchController.text); // Avoid duplicates
      _searchHistory.insert(0, _searchController.text);
      _saveSearchHistory();
    }
    switch (widget.type) {
      case SearchType.report:
        filterProposals = proposals.where((proposal) {
          // Apply the filter conditions for report (proposal) search type
          bool matchesQuery =
              proposal.proposalCode?.toLowerCase().contains(query) ?? false;
          bool matchesStatus = TextUtils.isEmpty(filters['status'])
              ? true
              : proposal.status == (filters['status']! == "Đã ký");
          bool matchesSigner = TextUtils.isEmpty(filters['signer'])
              ? true
              : proposal.signer?.contains(filters['signer']!) ?? false;
          final matchesVersion = TextUtils.isEmpty(filters["version"])
              ? true
              : (proposal.version is List &&
                  (proposal.version as List).contains(filters["version"]));

          return matchesQuery &&
              matchesStatus &&
              matchesSigner &&
              matchesVersion;
        }).toList();
        break;

      case SearchType.topic:
        filterTopics = topics.where((topic) {
          // Apply the filter conditions for topic search type
          bool matchesQuery =
              topic.topicCode?.toLowerCase().contains(query) ?? false;

          bool matchesType = TextUtils.isEmpty(filters['type'])
              ? true
              : filters['type'] == topic.type;
          bool matchesTopicCode = TextUtils.isEmpty(filters['topicCode'])
              ? true
              : filters['topicCode'] == topic.topicCode;
          bool matchesManagementLevel =
              TextUtils.isEmpty(filters['managementLevel'])
                  ? true
                  : filters['managementLevel'] == topic.levelManager;
          return matchesQuery &&
              matchesType &&
              matchesTopicCode &&
              matchesManagementLevel;
        }).toList();
        break;

      case SearchType.staff:
        filterStaff = staff.where((employee) {
          // Apply the filter conditions for staff search type
          bool matchesQuery =
              employee.employCode?.toLowerCase().contains(query) ?? false;

          bool matchesPosition = TextUtils.isEmpty(filters['position'])
              ? true
              : filters['position'] == employee.position;
          bool matchesSex = TextUtils.isEmpty(filters['sex'])
              ? true
              : filters['sex'] == employee.sex;
          return matchesQuery && matchesPosition && matchesSex;
        }).toList();
        break;

      default:
        break;
    }
  }
}
