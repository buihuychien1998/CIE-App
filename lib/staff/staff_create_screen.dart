import 'package:flutter/material.dart';
import 'package:home/models/staff_create_request.dart';
import 'package:home/models/staff_create_response.dart';
import 'package:intl/intl.dart';
import 'package:home/after_upload.dart';
import 'package:home/staff/staff_screen.dart';

import '../base/api_url.dart';
import '../base/base_loading_state.dart';
import '../extension/string_extension.dart';
import '../utils/toast_utils.dart';

final ValueNotifier<StaffCreateRequest> sharedStaffRequest =
    ValueNotifier(StaffCreateRequest());

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  _CreateStaffScreenState createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen>
    with BaseLoadingState {
  bool _isInformationComplete = false;
  bool _isRecruitmentComplete = false;

  void _checkCompletion() {
    setState(() {
      _isInformationComplete = _isInformationTabComplete();
      _isRecruitmentComplete = _isRecruitmentTabComplete();
    });
  }

  bool _isInformationTabComplete() {
    // Kiểm tra các trường thông tin trong tab "Thông tin"
    return !TextUtils.isEmpty(sharedStaffRequest.value.fullname) &&
        !TextUtils.isEmpty(sharedStaffRequest.value.employCode) &&
        !TextUtils.isEmpty(sharedStaffRequest.value.position) &&
        !TextUtils.isEmpty(sharedStaffRequest.value.idCardNumber);
  }

  bool _isRecruitmentTabComplete() {
    // Kiểm tra các trường thông tin trong tab "Phiên bản"
    return !TextUtils.isEmpty(sharedStaffRequest.value.levelSalary) &&
        !TextUtils.isEmpty(sharedStaffRequest.value.multiplier);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            'Thêm mới nhân sự',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: (_isInformationComplete && _isRecruitmentComplete)
                  ? () {
                createStaff();
              }
                  : null,
              child: Text(
                'Lưu',
                style: TextStyle(
                  color: (_isInformationComplete && _isRecruitmentComplete)
                      ? Colors.blue
                      : Colors.grey,
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
              Tab(text: 'Tuyển dụng'),
              Tab(text: 'Tài liệu'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const InformationTab(),
            const RecruitmentTab(),
            DocumentsTab(onFileSelected: _checkCompletion),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    clearData();
    super.dispose();
  }

  void clearData() {
    sharedStaffRequest.value = StaffCreateRequest(); // Clear data
    sharedStaffRequest.notifyListeners(); // Notify listeners to update UI
  }

  Future<void> createStaff() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = sharedStaffRequest.value;
      final data = await apiService.post(ApiUrl.post_create_employee(),
          body: body.toJson());

      StaffCreateResponse response = StaffCreateResponse.fromJson(data);
      if (response.employee?.id != null) {
        ToastUtils.showSuccess("Bạn đã thêm nhân sự thành công!");
        Navigator.pop(context, true);
      } else {
        ToastUtils.showError(
            "Thêm nhân sự không thành công. Vui lòng kiểm tra và thử lại!");
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }
}

// Tab Thông tin
class InformationTab extends StatefulWidget {
  const InformationTab({Key? key}) : super(key: key);

  @override
  _InformationTabState createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _cardIDController = TextEditingController();
  final TextEditingController _socialCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _foreignLangController = TextEditingController();
  final TextEditingController _itLevelController = TextEditingController();
  String _birthDay = '';
  String _joinDate = '';

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    _fullNameController.addListener(() {
      sharedStaffRequest.value.fullname = _fullNameController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _positionController.addListener(() {
      sharedStaffRequest.value.position = _positionController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _codeController.addListener(() {
      sharedStaffRequest.value.employCode = _codeController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _cardIDController.addListener(() {
      sharedStaffRequest.value.idCardNumber = _cardIDController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _socialCodeController.addListener(() {
      sharedStaffRequest.value.socialCode = _socialCodeController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _addressController.addListener(() {
      sharedStaffRequest.value.address = _addressController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _educationController.addListener(() {
      sharedStaffRequest.value.education = _codeController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _levelController.addListener(() {
      sharedStaffRequest.value.level = _levelController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _foreignLangController.addListener(() {
      sharedStaffRequest.value.foreignLang = _foreignLangController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _itLevelController.addListener(() {
      sharedStaffRequest.value.itLevel = _itLevelController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _positionController.dispose();
    _codeController.dispose();
    _cardIDController.dispose();
    _socialCodeController.dispose();
    _addressController.dispose();
    _levelController.dispose();
    _foreignLangController.dispose();
    _itLevelController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _selectBirthDay(BuildContext context) async {
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
        _birthDay = DateFormat('dd/MM/yyyy').format(selectedDate);
        sharedStaffRequest.value.birthday = _birthDay;
        sharedStaffRequest.notifyListeners(); // Notify listeners if needed
        _checkCompletion();
      });
    }
  }

  Future<void> _selectJoinClanDate(BuildContext context) async {
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
        _joinDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        sharedStaffRequest.value.joinClan = _joinDate;
        sharedStaffRequest.notifyListeners(); // Notify listeners if needed
        _checkCompletion();
      });
    }
  }

  void _checkCompletion() {
    final addStaffState =
        context.findAncestorStateOfType<_CreateStaffScreenState>();
    addStaffState?._checkCompletion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần "Tên tên"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Họ tên',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 16),

          // Mục chức vụ
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Chức vụ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _positionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Mã NV
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Mã NV',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
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
                  'Ngày sinh',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () => _selectBirthDay(context),
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
                              _birthDay.isEmpty ? '' : _birthDay,
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
                          onPressed: () => _selectBirthDay(context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),

          // Mục CCCD
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Số CCCD',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _cardIDController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục BHXH
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Số BHXH',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _socialCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Nơi ở
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Nơi ở',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(
            color: Colors.grey[300],
            thickness: 2.0,
          ),
          SizedBox(height: 16),

          // Mục Học vấn
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Học vấn',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _educationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Trình độ
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Trình độ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _levelController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Ngoại ngữ
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngoại ngữ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _foreignLangController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục tin học
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Tin học',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _itLevelController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Ngày vào Đảng
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày vào Đảng CSVN',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () => _selectJoinClanDate(context),
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
                              _joinDate.isEmpty ? '' : _joinDate,
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
                          onPressed: () => _selectJoinClanDate(context),
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
}

// Tab Tuyển dụng
class RecruitmentTab extends StatefulWidget {
  const RecruitmentTab({super.key});

  @override
  _RecruitmentTabState createState() => _RecruitmentTabState();
}

class _RecruitmentTabState extends State<RecruitmentTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _multiplierController = TextEditingController();
  final TextEditingController _extendSalaryController = TextEditingController();
  String _joinDate = '';
  String _paidDate = '';

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    _salaryController.addListener(() {
      sharedStaffRequest.value.levelSalary = _salaryController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _multiplierController.addListener(() {
      sharedStaffRequest.value.multiplier = _multiplierController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _extendSalaryController.addListener(() {
      sharedStaffRequest.value.extendSalary = _extendSalaryController.text;
      sharedStaffRequest.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
  }

  @override
  void dispose() {
    _salaryController.dispose();
    _multiplierController.dispose();
    _extendSalaryController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _selectJoinDate(BuildContext context) async {
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
        _joinDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        sharedStaffRequest.value.dateJoin = _joinDate;
        sharedStaffRequest.notifyListeners(); // Notify listeners if needed
        _checkCompletion();
      });
    }
  }

  Future<void> _selectPaidDate(BuildContext context) async {
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
        _paidDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        sharedStaffRequest.value.payday = _paidDate;
        sharedStaffRequest.notifyListeners(); // Notify listeners if needed
        _checkCompletion();
      });
    }
  }

  void _checkCompletion() {
    final addStaffState =
        context.findAncestorStateOfType<_CreateStaffScreenState>();
    addStaffState?._checkCompletion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần Ngày tuyển
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Ngày tuyển',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () => _selectJoinDate(context),
                      // Handle tap on the entire container
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          // Border color
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _joinDate.isEmpty ? '' : _joinDate,
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
                              onPressed: () => _selectJoinDate(context),
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
          SizedBox(height: 16),

          // Mục Ngày hưởng
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày hưởng',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () => _selectPaidDate(context),
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
                              _paidDate.isEmpty ? '' : _paidDate,
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
                          onPressed: () => _selectPaidDate(context),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),

          // Mục bậc lương
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Bậc lương',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _salaryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Hệ số
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Hệ số',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _multiplierController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục phụ cấp
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Phụ cấp',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _extendSalaryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Tab tài liệu
class DocumentsTab extends StatelessWidget {
  final VoidCallback onFileSelected;

  const DocumentsTab({super.key, required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mục CCCD
          Text(
            'CCCD',
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

          // Mục bằng cấp
          Text(
            'Bằng cấp',
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

          // Mục hợp đồng
          Text(
            'Hợp đồng',
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
