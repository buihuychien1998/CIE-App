import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/home/search_home.dart';
import 'package:home/report/report_detail_screen.dart';
import 'package:home/report/report_filter_screen.dart';
import 'package:home/report/report_create_screen.dart';
import 'package:home/utils/toast_utils.dart';

import '../base/api_url.dart';
import '../constants/size_constants.dart';
import '../models/employee_response.dart';
import '../models/proposal_response.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with BaseLoadingState {
  List<Proposal>? _rows;
  List<Proposal>? _filteredRows;

  @override
  void initState() {
    super.initState();
    getAllProposal();
    _filteredRows = _rows;
  }

  void _handleDeleteRow(int index) {
    setState(() {
      _rows?.removeAt(index);
      _filteredRows?.removeAt(index);
    });
  }

  void _navigateToDetailPage(BuildContext context, Proposal? proposal) async {
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

  void _showDeleteConfirmationSheet(BuildContext context, int index) {
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
                      _handleDeleteRow(index);
                      Navigator.of(context).pop(true);
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

  void _navigateToFilterPage(BuildContext context) async {
    final filters = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => ReportFilterScreen(
          onApplyFilter: (filters) {
            setState(() {
              _filteredRows = _rows?.where((row) {
                bool matchesStatus = row.status == filters['status']!;
                bool matchesSigner = row.signer?.contains(filters['signer']!) ?? false;
                // bool matchesSigner = row.signer?.contains(filters['signer']!) ?? false;
                return matchesStatus && matchesSigner;
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
            const Align(
              alignment: Alignment(0, -0.85),
              child: Text(
                'Quản lý tờ trình',
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
                                      builder: (context) => const SearchHome(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: const Color(0xFFEBEBEB),
                                      // Thêm viền màu xanh
                                      width: 1.0,
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.search, color: Colors.grey),
                                      marginW10,
                                      Text(
                                        'Nhập từ khoá ',
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
                                          label: Text('Số tờ trình',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(
                                          label: Text('Người ký',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(
                                          label: Text('Trạng thái',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: List.generate(
                                        _filteredRows?.length ?? 0, (index) {
                                      Proposal? proposal =
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                                color: proposal?.status == true
                                                    ? const Color(0xFFEAFFEC)
                                                    : const Color(0xFFFFEEEE),
                                              ),
                                              child: Text(
                                                proposal?.status == true
                                                    ? 'Đã ký'
                                                    : "Chưa ký",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: proposal?.status ==
                                                          true
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
                                                  margin: const EdgeInsets.only(
                                                      top: 1),
                                                  color:
                                                      const Color(0xFF4285F4),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _navigateToDetailPage(
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
                                                      _showDeleteConfirmationSheet(
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
            onPressed: () {
              getAllEmployee();
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

  Future<void> getAllProposal() async {
    progressStream.add(true);

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_proposal(),
      );

      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        _rows = response.proposal ?? [];
        _filteredRows = response.proposal ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
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
          builder: (context) => ReportCreateScreen(
            employee: response.employee ?? [],
          ), // Điều hướng đến trang AddReport
        ),
      );
      if (result) {
        getAllProposal();
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      progressStream.add(false);
    }
  }
}
