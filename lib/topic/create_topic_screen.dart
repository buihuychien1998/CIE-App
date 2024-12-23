import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/models/topic_create_response.dart';
import 'package:intl/intl.dart';
import 'package:home/after_upload.dart';
import 'package:home/topic/topic_screen.dart';

import '../base/api_url.dart';
import '../base/base_loading_state.dart';
import '../extension/string_extension.dart';
import '../models/topic_create_request.dart';
import '../utils/toast_utils.dart';

final ValueNotifier<DataCreate> sharedTopicInformation =
    ValueNotifier(DataCreate());
final ValueNotifier<List<Student>> sharedProposalStudents = ValueNotifier([]);

class CreateTopicScreen extends StatefulWidget {
  const CreateTopicScreen({super.key});

  @override
  _CreateTopicScreenState createState() => _CreateTopicScreenState();
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

class _CreateTopicScreenState extends State<CreateTopicScreen>
    with BaseLoadingState {
  bool _isInformationComplete = false;
  bool _isMemberComplete = false;

  void _checkCompletion() {
    setState(() {
      _isInformationComplete = _isInformationTabComplete();
      _isMemberComplete = _isMemberTabComplete();
    });
  }

  bool _isInformationTabComplete() {
    print(sharedTopicInformation.value.toJson());
    return !TextUtils.isEmpty(sharedTopicInformation.value.nameTopic) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.topicCode) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.type) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.unit) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.levelManager) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.burget) &&
        !TextUtils.isEmpty(sharedTopicInformation.value.year);
  }

  bool _isMemberTabComplete() {
    // Check if all students have non-empty fields
    final isComplete = sharedProposalStudents.value.every((student) {
      print(student.toJson());
      return student.fullname?.trim().isNotEmpty == true &&
          student.studentCode?.trim().isNotEmpty == true &&
          student.positionName?.trim().isNotEmpty == true;
    });
    return isComplete;
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
            'Thêm mới đề tài',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: (_isInformationComplete && _isMemberComplete)
                  ? () {
                      createTopic();
                    }
                  : null,
              child: Text(
                'Lưu',
                style: TextStyle(
                  color: (_isInformationComplete && _isMemberComplete)
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
              Tab(text: 'Thành viên'),
              Tab(text: 'Hồ sơ'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InformationTab(),
            MemberTab(),
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
    sharedTopicInformation.value = DataCreate(); // Clear data
    sharedTopicInformation.notifyListeners(); // Notify listeners to update UI
    sharedProposalStudents.value = [];
    sharedProposalStudents.notifyListeners(); // Notify listeners to update UI
  }

  Future<void> createTopic() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      final body = TopicCreateRequest();
      body.dataCreate = sharedTopicInformation.value;
      body.student ??= [];
      body.student?.addAll(sharedProposalStudents.value);
      final data = await apiService.post(ApiUrl.post_create_topic(),
          body: body.toJson());

      TopicCreateResponse response = TopicCreateResponse.fromJson(data);
      if (response.topic != null) {
        ToastUtils.showSuccess("Bạn đã thêm đề tài thành công!");
        Navigator.pop(context, true);
      } else {
        ToastUtils.showError(
            "Thêm đề tài không thành công. Vui lòng kiểm tra và thử lại!");
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  // final TextEditingController _managementLevelController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    sharedTopicInformation.value.type = "Đề tài";
    sharedTopicInformation.value.levelManager = "Cấp học viện";
    sharedTopicInformation.notifyListeners(); // Notify listeners if needed
    _nameController.addListener(() {
      sharedTopicInformation.value.nameTopic = _nameController.text;
      sharedTopicInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _codeController.addListener(() {
      sharedTopicInformation.value.topicCode = _codeController.text;
      sharedTopicInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _unitController.addListener(() {
      sharedTopicInformation.value.unit = _unitController.text;
      sharedTopicInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    // _managementLevelController.addListener(() {
    //   sharedTopicInformation.value.levelManager = _managementLevelController.text;
    //   sharedTopicInformation.notifyListeners(); // Notify listeners if needed
    //   _checkCompletion();
    // });
    _budgetController.addListener(() {
      sharedTopicInformation.value.burget = _budgetController.text;
      sharedTopicInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
    _yearController.addListener(() {
      sharedTopicInformation.value.year = _yearController.text;
      sharedTopicInformation.notifyListeners(); // Notify listeners if needed
      _checkCompletion();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _unitController.dispose();
    // _managementLevelController.dispose();
    _budgetController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _checkCompletion() {
    final addTopicState =
        context.findAncestorStateOfType<_CreateTopicScreenState>();
    addTopicState?._checkCompletion();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần "Tên đề tài"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên đề tài',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _nameController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Nhập tên đề tài',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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

          // Mục Loại hình
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Loại hình',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: TextEditingController(text: "Đề tài"),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Đơn vị
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Đơn vị',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _unitController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Cấp quản lý
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Cấp quản lý',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: TextEditingController(text: "Cấp học viện"),
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Kinh phí
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Kinh phí',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _budgetController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Mục Năm
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Năm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  keyboardType: TextInputType.number,
                  // Specifies the keyboard for numbers
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // Allows only numeric input
                  ],
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

// Tab Thành viên
class MemberTab extends StatefulWidget {
  const MemberTab({super.key});

  @override
  _MemberTabState createState() => _MemberTabState();
}

class _MemberTabState extends State<MemberTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.addListener(_checkCompletion);
    _infoController.addListener(_checkCompletion);
    _addMember(); // Add initial member
  }

  @override
  void dispose() {
    _dateController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  void _checkCompletion() {
    final addTopicState =
        context.findAncestorStateOfType<_CreateTopicScreenState>();
    addTopicState?._checkCompletion();
  }

  void _addMember() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sharedProposalStudents.value.add(Student()); // Add a new Student object
      sharedProposalStudents.notifyListeners(); // Notify listeners after the frame completes
      _checkCompletion();
    });
  }

  void _removeMember(int index) {
    if (sharedProposalStudents.value.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sharedProposalStudents.value.removeAt(index); // Remove the student
        sharedProposalStudents.notifyListeners(); // Notify listeners after the frame completes
        _checkCompletion();
      });
    }
  }

  Widget _buildMember(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thành viên ${index + 1}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(
                Icons.do_not_disturb_on,
                color: sharedProposalStudents.value.length > 1
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: sharedProposalStudents.value.length > 1
                  ? () => _removeMember(index)
                  : null,
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildTextField(
          label: 'Họ tên',
          initialValue: sharedProposalStudents.value[index].fullname,
          onChanged: (value) {
            sharedProposalStudents.value[index].fullname = value;
            sharedProposalStudents
                .notifyListeners(); // Notify listeners about the update
            _checkCompletion();
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          label: 'Định danh',
          initialValue: sharedProposalStudents.value[index].studentCode,
          onChanged: (value) {
            sharedProposalStudents.value[index].studentCode = value;
            sharedProposalStudents
                .notifyListeners(); // Notify listeners about the update
            _checkCompletion();
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          label: 'Vai trò',
          initialValue: sharedProposalStudents.value[index].positionName,
          onChanged: (value) {
            sharedProposalStudents.value[index].positionName = value;
            sharedProposalStudents
                .notifyListeners(); // Notify listeners about the update
            _checkCompletion();
          },
        ),
        SizedBox(height: 10),
        if (sharedProposalStudents.value.length > 1 &&
            index < sharedProposalStudents.value.length - 1)
          Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String? initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextField(
            controller: TextEditingController(text: initialValue)
              ..selection =
                  TextSelection.collapsed(offset: initialValue?.length ?? 0),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Student>>(
        valueListenable: sharedProposalStudents,
        builder: (context, students, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < students.length; i++) _buildMember(i),
                if (students.isNotEmpty) SizedBox(height: 10),
                if (students.isNotEmpty)
                  Divider(color: Colors.grey, thickness: 1),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 20,
                        ),
                        onPressed: _addMember,
                      ),
                      SizedBox(width: 0.1),
                      TextButton(
                        onPressed: _addMember,
                        child: Text(
                          'Thêm',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

// Tab Hồ sơ
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
            'Thuyết minh',
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
            'Đề cương',
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
