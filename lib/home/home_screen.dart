import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graphic/graphic.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/database/database_home.dart';
import 'package:home/models/reports.dart';
import 'package:home/search/search_screen.dart';
import 'package:home/topic/topic_create_screen.dart';
import 'package:home/staff/staff_create_screen.dart';

import '../base/api_url.dart';
import '../constants/app_constants.dart';
import '../constants/size_constants.dart';
import '../models/employee_response.dart';
import '../models/proposal_response.dart';
import '../models/topic_response.dart';
import '../models/chart_response.dart' as chart;
import '../models/user_profile_response.dart';
import '../report/report_create_screen.dart';
import '../search/filter_screen.dart';
import '../utils/toast_utils.dart';
import 'dashboard_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with BaseLoadingState {
  late Future<List<Reports>> _reportsFuture;
  List<Proposal> proposals = [];
  List<Topic> topics = [];
  List<Employee> staff = [];
  List<Map> chartData = [];

  @override
  void initState() {
    super.initState();
    _reportsFuture = DatabaseService().getReports();
    _fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          // _buildSearchBar(),
          marginH20,
          _buildCategoryRows(),
          marginH24,
          _buildBarChart(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            left: 0,
            right: 0,
            bottom: 10,
          ),
          child: Image.asset(
            'assets/images/logoCIE.png',
            width: 47,
            height: 52,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Image.asset(
                'assets/images/scan.png',
                color: Colors.black,
                width: 24,
                height: 24,
              ),
              onPressed: () {
                // Xử lý khi ấn vào biểu tượng scan
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/bell.png',
                color: Colors.black,
                width: 24,
                height: 24,
              ),
              onPressed: () {
                // Xử lý khi ấn vào biểu tượng scan
              },
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(type: SearchType.all),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFEBEBEB),
                  width: 1.0,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  marginW10,
                  Text(
                    'Nhập từ khóa',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          marginW10,
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FilterScreen(
                        onApplyFilter: (filters) {},
                        type: SearchType.all,
                      ),
                ),
              );
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
            child: const Icon(Icons.tune, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRows() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              getAllEmployee();
            },
            child: _buildCategoryCard(
              title: 'Tờ trình',
              image: 'assets/images/image1.png',
              count: proposals.length,
            ),
          ),
        ),
        marginW20,
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TopicCreateScreen()),
              );
            },
            child: _buildCategoryCard(
              title: 'Đề tài',
              image: 'assets/images/image2.png',
              count: topics.length,
            ),
          ),
        ),
        marginW20,
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateStaffScreen()),
              );
            },
            child: _buildCategoryCard(
              title: 'Nhân sự',
              image: 'assets/images/image3.png',
              count: staff.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String image,
    required int count,
  }) {
    return Container(
      width: 98,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          if (count > 0)
            Positioned(
              top: 35,
              left: 10,
              right: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 10,
            bottom: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Thêm mới +',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
                marginH10,
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Đề tài các năm',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        marginH20,
        chartData.isEmpty ? const SizedBox.shrink() : SizedBox(
          width: double.infinity,
          height: 200,
          child: Chart(
            data: chartData,
            variables: {
              'Năm': Variable(
                accessor: (Map map) => map['year'] as String,
              ),
              'Số lượng': Variable(
                accessor: (Map map) => map['count'] as num,
              ),
            },
            marks: [IntervalMark()],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
          ),
        ),
        marginH24,
        const Text(
          'Trạng thái tờ trình',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        marginH10,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: DataTable(
            columnSpacing: 20,
            columns: const [
              DataColumn(label: Flexible(child: Text('TT'))),
              DataColumn(label: Flexible(child: Text('Số tờ trình'))),
              DataColumn(label: Flexible(child: Text('Người ký'))),
              DataColumn(label: Flexible(child: Text('Trạng thái'))),
            ],
            rows: List.generate(
              proposals.length,
                  (index) {
                Proposal item = proposals[index];
                return DataRow(cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(item.proposalCode ?? "")),
                  // Replace with actual data
                  DataCell(Text(item.signer ?? "")),
                  // Replace with actual data
                  DataCell(Text(item.status == true ? "Đã ký" : "Chưa ký")),
                  // Replace with actual data
                ]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _fetchAllData() async {
    progressStream.add(true);
    try {
      await Future.wait(
          [
            getAllProposal(),
            getAllTopic(),
            getAllStaff(),
            getChartData(),
            getUserProfile()
          ]);
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }

  Future<void> getAllProposal() async {
    try {
      final data = await apiService.get(ApiUrl.get_all_proposal());
      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        proposals = response.proposal ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> getAllTopic() async {
    try {
      final data = await apiService.get(ApiUrl.get_all_topic());
      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        topics = response.topic ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> getAllStaff() async {
    try {
      final data = await apiService.get(ApiUrl.get_all_employee());
      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        staff = response.employee ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> getChartData() async {
    try {
      final data = await apiService.get(ApiUrl.get_chart_data());
      chart.ChartResponse response = chart.ChartResponse.fromJson(data);
      setState(() {
        chartData = [];
        for (var item in (response.topic ?? [])) {
          chartData.add(item.toJson());
        }
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> getAllEmployee() async {
    progressStream.add(true);

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      if (response.employee?.isEmpty ?? true) {
        ToastUtils.showInfo('Để tiếp tục, vui lòng thêm nhân sự vào hệ thống.');
        return;
      }
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ReportCreateScreen(
                employee: response.employee ?? [],
              ), // Điều hướng đến trang AddReport
        ),
      );
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }

  Future<void> getUserProfile() async {
    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_profile(),
      );

      UserProfileResponse response = UserProfileResponse.fromJson(data);
      AppConstant.profile = response.profile;
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {}
  }
}
