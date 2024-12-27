import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/search/search_screen.dart';
import 'package:home/models/employee_response.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/topic/topic_screen.dart';
import 'package:home/staff/staff_detail_screen.dart';
import 'package:home/staff/staff_create_screen.dart';

import '../base/api_url.dart';
import '../base/base_loading_state.dart';
import '../constants/app_constants.dart';
import '../constants/size_constants.dart';
import '../search/filter_screen.dart';
import '../utils/toast_utils.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> with BaseLoadingState {
  List<Employee>? _rows;
  List<Employee>? _filteredRows;
  int? _expandedRowIndex;

  @override
  void initState() {
    super.initState();
    getAllEmployee();
    _filteredRows = _rows;
  }

  void _navigateToStaffDetailPage(BuildContext context, Employee? staff) async{
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
                'Xóa nhân sự này?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 12),
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
                      deleteStaff(_filteredRows?[index].employCode);
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
          type: SearchType.staff,
          onApplyFilter: (filters) {
            setState(() {
              _filteredRows = _rows?.where((row) {
                // bool matchesStatus =
                //     filters['status'] == '' || row.contains(filters['status']!);
                // bool matchesSigner =
                //     filters['signer'] == '' || row.contains(filters['signer']!);
                // return matchesStatus && matchesSigner;
                return true;
              }).toList();
            });
          },
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
                'Quản lý nhân sự',
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
                                      builder: (context) => SearchScreen(type: SearchType.staff),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
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
                                      const Text(
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
                                // _navigateToFilterPage(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(type: SearchType.staff),
                                  ),
                                );
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
                          child: _filteredRows == null
                              ? const SizedBox()
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )),
                                      DataColumn(
                                          label: Text('Họ tên',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(
                                          label: Text('Mã nhân viên',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(
                                          label: Text('Chức vụ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: List.generate(
                                        _filteredRows?.length ?? 0, (index) {
                                      Employee? employee =
                                          _filteredRows?[index];

                                      return DataRow(
                                        cells: [
                                          DataCell(Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
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
                                                  margin: const EdgeInsets.only(
                                                      top: 1),
                                                  color:
                                                      const Color(0xFF4285F4),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _navigateToStaffDetailPage(
                                                          context,
                                                          _filteredRows?[
                                                              index]);
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              color:
                                                                  Colors.white,
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
                                                  margin: const EdgeInsets.only(
                                                      top: 1),
                                                  color:
                                                      const Color(0xFFFC4D4D),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showDeleteStaffConfirmationSheet(
                                                          context, index);
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              color:
                                                                  Colors.white,
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
                  builder: (context) => const CreateStaffScreen(),
                ),
              );
              if (result) {
                getAllEmployee();
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

  Future<void> getAllEmployee() async {
    progressStream.add(true);

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        _rows = response.employee ?? [];
        _filteredRows = response.employee ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }

  Future<void> deleteStaff(String? code) async {
    progressStream.add(true);
    // Lấy dữ liệu từ form
    try {
      final body = {
        "employ_code": code
      };
      await apiService.post(ApiUrl.post_delete_employee(), body: body);
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        _rows = response.employee ?? [];
        _filteredRows = response.employee ?? [];
      });
      ToastUtils.showSuccess("Bạn đã xoá nhân sự thành công!");
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }

}
