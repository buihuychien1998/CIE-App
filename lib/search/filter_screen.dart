import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/extension/string_extension.dart';

import '../base/api_url.dart';
import '../constants/app_constants.dart';
import '../home/dashboard_screen.dart';
import '../models/employee_response.dart';
import '../models/proposal_response.dart';
import '../models/topic_response.dart';

class FilterScreen extends StatefulWidget {
  final SearchType type;

  final void Function(Map<String, dynamic> filters) onApplyFilter;

  const FilterScreen(
      {super.key, required this.type, required this.onApplyFilter});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> with BaseLoadingState {
  String _selectedStatus = '';
  String _selectedSigner = '';
  String _selectedVersion = '';
  String _selectedType = '';
  String _selectedTopicCode = '';
  String _selectedManagementLevel = '';
  String _selectedPosition = '';
  String _selectedSex = '';

  List<Proposal> proposals = [];
  List<Topic> topics = [];
  List<Employee> staff = [];
  List<String> versions = [];
  List<String> singers = [];
  List<String> topicCodes = [];
  List<String> types = [];
  List<String> positions = [];
  List<String> sexes = [];

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  void _showBottomSheet(
      String title, List<String> options, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 2 / 5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 3,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
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
    return buildWithLoading(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Bộ lọc',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
          body: widget.type == SearchType.report
              ? buildReportFilter(context)
              : widget.type == SearchType.topic
              ? buildTopicFilter(context)
              : buildStaffFilter(context),
        ));
  }

  Widget buildReportFilter(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownField(
                    'Người ký',
                    singers,
                    _selectedSigner,
                        (value) => setState(() => _selectedSigner = value),
                  ),
                  const SizedBox(height: 20),
                  buildDropdownField(
                    'Trạng thái',
                    ['Đã ký', 'Chưa ký'],
                    _selectedStatus,
                        (value) => setState(() => _selectedStatus = value),
                  ),
                  const SizedBox(height: 20),
                  buildDropdownField(
                    'Phiên bản',
                    versions,
                    _selectedVersion,
                        (value) => setState(() => _selectedVersion = value),
                  ),
                ],
              ),
            ),
          ),
        ),
        buildApplyButton(context),
      ],
    );
  }

  Widget buildTopicFilter(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownField(
                    'Loại hình',
                    types,
                    _selectedType,
                        (value) => setState(() => _selectedType = value),
                  ),
                  const SizedBox(height: 20),
                  buildDropdownField(
                    'Mã số',
                    topicCodes,
                    _selectedTopicCode,
                        (value) => setState(() => _selectedTopicCode = value),
                  ),
                  const SizedBox(height: 20),
                  buildDropdownField(
                    'Cấp quản lý',
                    ['Cấp học viện'],
                    _selectedManagementLevel,
                        (value) =>
                        setState(() => _selectedManagementLevel = value),
                  ),
                ],
              ),
            ),
          ),
        ),
        buildApplyButton(context),
      ],
    );
  }

  Widget buildStaffFilter(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownField(
                    'Chức vụ',
                    positions,
                    _selectedPosition,
                        (value) => setState(() => _selectedPosition = value),
                  ),
                  const SizedBox(height: 20),
                  buildDropdownField(
                    'Giới tính',
                    sexes,
                    _selectedSex,
                        (value) => setState(() => _selectedSex = value),
                  ),
                ],
              ),
            ),
          ),
        ),
        buildApplyButton(context),
      ],
    );
  }

  Widget buildDropdownField(String label, List<String> options, String selected,
      ValueChanged<String> onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showBottomSheet(label, options, onSelected),
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selected.isEmpty ? "Chọn" : selected,
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildApplyButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: _applyFilters,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          minimumSize: const Size(double.infinity, 45),
        ),
        child: const Text('Áp dụng', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {};

    switch (widget.type) {
      case SearchType.report:
        filters = {
          'status': _selectedStatus,
          'signer': _selectedSigner,
          'version': _selectedVersion,
        };
        break;

      case SearchType.topic:
        filters = {
          'type': _selectedType,
          'topicCode': _selectedTopicCode,
          'managementLevel': _selectedManagementLevel,
        };
        break;

      case SearchType.staff:
        filters = {
          'position': _selectedPosition,
          'sex': _selectedSex,
        };
        break;

      default:
        break;
    }
    Navigator.pop(context);

    widget.onApplyFilter(filters);
  }

  Future<void> _fetchAllData() async {
    showLoading();
    try {
      await Future.wait([
        getAllProposal(),
        getAllTopic(),
        getAllEmployee(),
      ]);
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

  Future<void> getAllProposal() async {
    try {
      final data = await apiService.get(ApiUrl.get_all_proposal());
      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        proposals = response.proposal ?? [];
        versions = proposals
            .where((e) => e.version != null) // Filter out proposals with null versions
            .expand((e) => e.version!.map((v) => v.nameVersion ?? '')) // Map and expand to flatten the nested lists
            .where((name) => name.isNotEmpty) // Exclude empty strings
            .toSet()
            .toList();
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
        topicCodes = topics.map((e) => e.topicCode ?? '').toSet().toList();
        types = topics.map((e) => e.type ?? '').toSet().toList();
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> getAllEmployee() async {
    try {
      final data = await apiService.get(ApiUrl.get_all_employee());
      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        staff = response.employee ?? [];
        positions = staff.map((e) => e.position ?? '').toSet().toList();
        sexes = staff.map((e) => e.sex ?? '').toSet().toList();
        singers = staff.map((e) => e.fullname ?? '').toSet().toList();
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }
}
