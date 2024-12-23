import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/models/employee_response.dart';
import 'package:home/utils/toast_utils.dart';
import 'package:intl/intl.dart';
import 'package:home/after_upload.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/home/dashboard_screen.dart';

import '../base/api_url.dart';
import '../extension/string_extension.dart';
import '../models/proposal_create_request.dart';
import '../models/proposal_create_response.dart';

// Shared state using ValueNotifier
final ValueNotifier<String> sharedProposalCode = ValueNotifier('');
final ValueNotifier<DataCreate> sharedProposalInformation =
    ValueNotifier(DataCreate());
final ValueNotifier<Version> sharedProposalVersion = ValueNotifier(Version());

class ReportCreateScreen extends StatefulWidget {
  final List<Employee> employee;

  const ReportCreateScreen({super.key, required this.employee});

  @override
  _ReportCreateScreenState createState() => _ReportCreateScreenState();
}

class _ReportCreateScreenState extends State<ReportCreateScreen>
    with BaseLoadingState {
  bool _isInformationComplete = false;

  void _checkCompletion() {
    print("_checkCompletion");
    print(sharedProposalInformation.value.toJson());
    setState(() {
      _isInformationComplete = _isInformationTabComplete();
    });
  }

  bool _isInformationTabComplete() {
    return !TextUtils.isEmpty(sharedProposalInformation.value.nameProposal) &&
        !TextUtils.isEmpty(sharedProposalInformation.value.proposalCode) &&
        !TextUtils.isEmpty(sharedProposalInformation.value.dateCreated) &&
        !TextUtils.isEmpty(sharedProposalInformation.value.signer) &&
        sharedProposalInformation.value.status != null;
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Thêm mới tờ trình',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: _isInformationComplete
                  ? () {
                      createProposal();
                    }
                  : null,
              child: Text(
                'Lưu',
                style: TextStyle(
                  color: _isInformationComplete ? Colors.blue : Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Color(0xFF4285F4),
            unselectedLabelColor: Color(0xFFA1A5B0),
            labelStyle: TextStyle(fontSize: 17),
            indicator: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF4285F4),
                  width: 3.0,
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            // Đảm bảo indicator phủ toàn bộ tab
            indicatorPadding: EdgeInsets.zero,
            // Đặt padding là 0 để indicator dài bằng tab
            tabs: [
              Tab(text: 'Thông tin'),
              Tab(text: 'Phiên bản'),
              Tab(text: 'Tài liệu'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InformationTab(
              employee: widget.employee,
            ),
            VersionTab(),
            DocumentsTab(onFileSelected: _checkCompletion),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    clearData();
    super.dispose();
  }

  void clearData() {
    sharedProposalInformation.value = DataCreate(); // Clear data
    sharedProposalInformation.notifyListeners(); // Notify listeners to update UI
  }

  Future<void> createProposal() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = ProposalCreateRequest();
      body.dataCreate = sharedProposalInformation.value;
      body.version ??= [];
      body.version?.add(sharedProposalVersion.value);
      final data = await apiService.post(ApiUrl.post_create_proposal(),
          body: body.toJson());

      ProposalCreateResponse response = ProposalCreateResponse.fromJson(data);
      if (response.proposal?.id != null) {
        ToastUtils.showSuccess("Bạn đã thêm tờ trình thành công!");
        Navigator.pop(context, true);
      } else {
        ToastUtils.showError(
            "Thêm tờ trình không thành công. Vui lòng kiểm tra và thử lại!");
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }
}

class FileSelectionConfirmationPage extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const FileSelectionConfirmationPage({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1),
                Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 3.6,
                      width: 65, // Chiều dài đường line
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius:
                            BorderRadius.circular(15), // Bo góc đường line
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Khoảng cách giữa đường line và chữ 'Tải file'
                Text(
                  'Tải file',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cho phép chọn file từ thư mục của bạn',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Nền trắng
                          foregroundColor: Colors.blue, // Màu chữ xanh
                          side: BorderSide(color: Colors.blue), // Viền xanh
                        ),
                        child: Text('Hủy'),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AfterUpload()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Nền xanh
                          foregroundColor: Colors.white, // Màu chữ trắng
                        ),
                        child: Text('Xác nhận'),
                      ),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}

class UpdateTrangThai extends StatefulWidget {
  final ValueChanged<String> onStatusChanged;

  const UpdateTrangThai({
    Key? key,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  _UpdateTrangThaiState createState() => _UpdateTrangThaiState();
}

class _UpdateTrangThaiState extends State<UpdateTrangThai> {
  String _selectedStatus = ''; //

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 1),
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 3.6,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Trạng thái',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Chọn trạng thái của tờ trình',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 25,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedStatus = 'Đã ký'; // Chọn 'Đã ký'
                        widget.onStatusChanged(
                            _selectedStatus); // Gọi hàm khi chọn
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedStatus == 'Đã ký'
                                  ? Color(0xFF44B971)
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: _selectedStatus == 'Đã ký'
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF44B971),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Text(
                          'Đã ký',
                          style: TextStyle(
                            color: Color(0xFF44B971),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  // Khoảng cách giữa các lựa chọn trạng thái
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    height: 25, // Khoảng cách giữa các vạch phân chia
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedStatus = 'Chưa ký'; // Chọn 'Chưa ký'
                        widget.onStatusChanged(
                            _selectedStatus); // Gọi hàm khi chọn
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedStatus == 'Chưa ký'
                                  ? Color(0xFFFC4D4D)
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: _selectedStatus == 'Chưa ký'
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFC4D4D),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Text(
                          'Chưa ký',
                          style: TextStyle(
                            color: Color(0xFFFC4D4D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5), // Khoảng cách giữa các lựa chọn trạng thái
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 20, // Khoảng cách giữa các vạch phân chia
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onStatusChanged(_selectedStatus);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 12), // Padding cho nút
                  ),
                  child: Text('Chọn'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Tab Thông tin
class InformationTab extends StatefulWidget {
  final List<Employee> employee;

  const InformationTab({super.key, required this.employee});

  @override
  _InformationTabState createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _proposalNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String _selectedDate = ''; // Use String variable instead of TextEditingController
  String? _status;
  Employee? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    _proposalNameController.addListener(() {
      final proposalInformation = sharedProposalInformation.value;
      proposalInformation.nameProposal = _proposalNameController.text;
      sharedProposalInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _codeController.addListener(() {
      final proposalInformation = sharedProposalInformation.value;
      proposalInformation.proposalCode = _codeController.text;
      sharedProposalInformation.notifyListeners(); // Notify listeners if needed
      sharedProposalCode.value = _codeController.text;
      _checkCompletion();
    });
  }

  @override
  void dispose() {
    print("_InformationTabState dispose");
    _proposalNameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        final proposalInformation = sharedProposalInformation.value;
        proposalInformation.dateCreated = _selectedDate;
        sharedProposalInformation
            .notifyListeners(); // Notify listeners if needed
        _checkCompletion();
      });
    }
  }

  void _checkCompletion() {
    final addReportState =
        context.findAncestorStateOfType<_ReportCreateScreenState>();
    addReportState?._checkCompletion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần "Tên tờ trình"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên tờ trình',
                style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _proposalNameController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Nhập tên tờ trình',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272727)),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Mã số
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Mã số',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272727)),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Ngày
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () => _selectDate(context),
                  // Handle tap on the entire container
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _selectedDate.isEmpty ? '' : _selectedDate,
                              // Display selected date
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272727)),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),

          // Mục Người ký
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Người ký',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(8.0), // Border radius
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Employee>(
                      value: _selectedEmployee,
                      hint: Text('Chọn nhân sự'),
                      isExpanded: true,
                      onChanged: (Employee? newValue) {
                        setState(() {
                          _selectedEmployee = newValue;
                          final proposalInformation =
                              sharedProposalInformation.value;
                          proposalInformation.signer = newValue?.fullname;
                          sharedProposalInformation
                              .notifyListeners(); // Notify listeners if needed
                          _checkCompletion();
                        });
                      },
                      iconStyleData: const IconStyleData(
                        icon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      items: widget.employee
                          .map<DropdownMenuItem<Employee>>((Employee employee) {
                        return DropdownMenuItem<Employee>(
                          value: employee,
                          child: Text(
                            employee.fullname ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Trạng thái
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Trạng thái',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return UpdateTrangThai(
                          onStatusChanged: (status) {
                            setState(() {
                              _status = status;
                              final proposalInformation =
                                  sharedProposalInformation.value;
                              proposalInformation.status = status == "Đã ký";
                              sharedProposalInformation.value =
                                  proposalInformation;
                              sharedProposalInformation
                                  .notifyListeners(); // Notify listeners if needed
                              _checkCompletion();
                            });
                          },
                        );
                      },
                    );
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _status ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _status == 'Đã ký'
                                ? Color(0xFF44B971)
                                : Color(0xFFFC4D4D),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Tab Phiên bản
class VersionTab extends StatefulWidget {
  const VersionTab({Key? key}) : super(key: key);

  @override
  _VersionTabState createState() => _VersionTabState();
}

class _VersionTabState extends State<VersionTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _versionNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _versionSignerController =
      TextEditingController();
  final TextEditingController _versionFWDController = TextEditingController();
  String _selectedDate = '';

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    _versionNameController.addListener(() {
      sharedProposalVersion.value.nameVersion = _versionNameController.text;
      sharedProposalVersion.notifyListeners();
    });
    _versionSignerController.addListener(() {
      sharedProposalVersion.value.signerVersion = _versionSignerController.text;
      sharedProposalVersion.notifyListeners();
    });
    _versionFWDController.addListener(() {
      sharedProposalVersion.value.fwd = _versionFWDController.text;
      sharedProposalVersion.notifyListeners();
    });
  }

  @override
  void dispose() {
    _versionNameController.dispose();
    _versionSignerController.dispose();
    _versionFWDController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        sharedProposalVersion.value.dateVersionCreated = _selectedDate;
        sharedProposalVersion.notifyListeners();
      });
    }
  }

  void _checkCompletion() {
    final addReportState =
        context.findAncestorStateOfType<_ReportCreateScreenState>();
    addReportState?._checkCompletion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần "Tên phiên bản"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên tờ trình',
                style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _versionNameController,
                maxLines: null,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272727)),
                decoration: InputDecoration(
                  hintText: 'Nhập tên tờ trình',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Mã số
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Mã số',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: ValueListenableBuilder(
                    valueListenable: sharedProposalCode,
                    builder: (context, value, child) {
                      _codeController.text = sharedProposalCode.value;
                      return TextField(
                          controller: _codeController,
                          enabled: false,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400]),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ));
                    }),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Ngày
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () => _selectDate(context),
                  // Handle tap on the entire container
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _selectedDate.isEmpty ? '' : _selectedDate,
                              // Display selected date
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272727)),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),

          // Mục Người ký
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Người ký',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _versionSignerController,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272727)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục FWD
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'FWD',
                  style: TextStyle(fontSize: 16, color: Color(0xFF272727)),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _versionFWDController,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272727)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Tab Tài liệu
class DocumentsTab extends StatelessWidget {
  final VoidCallback onFileSelected;

  const DocumentsTab({Key? key, required this.onFileSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mục "File chưa ký"
          Text(
            'File chưa ký',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.3),
                  builder: (BuildContext context) {
                    return FileSelectionConfirmationPage(
                      onConfirm: () {
                        Navigator.of(context).pop();
                        // Code để chọn file từ máy
                        onFileSelected();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, color: Colors.blue, size: 20),
                  SizedBox(height: 4),
                  Text(
                    'Nhấn để tải lên',
                    style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Mục "Báo cáo"
          Text(
            'Báo cáo',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.3),
                  builder: (BuildContext context) {
                    return FileSelectionConfirmationPage(
                      onConfirm: () {
                        Navigator.of(context).pop();
                        // Code để chọn file từ máy
                        onFileSelected();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, color: Colors.blue, size: 20),
                  SizedBox(height: 4),
                  Text(
                    'Nhấn để tải lên',
                    style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
