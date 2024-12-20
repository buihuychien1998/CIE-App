import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:home/after_upload.dart';
import 'package:home/topic/topic_screen.dart';

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

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  bool _isInformationComplete = false;
  bool _isVersionComplete = false;
  bool _isDocumentsComplete = false;

  void _checkCompletion() {
    setState(() {
      _isInformationComplete = _isInformationTabComplete();
      _isVersionComplete = _isVersionTabComplete();
      _isDocumentsComplete = _isDocumentsTabComplete();
    });
  }

  bool _isInformationTabComplete() {
    // Kiểm tra các trường thông tin trong tab "Thông tin"
    return true; // Thay đổi điều kiện này tùy thuộc vào cách kiểm tra của bạn
  }

  bool _isVersionTabComplete() {
    // Kiểm tra các trường thông tin trong tab "Phiên bản"
    return true; // Thay đổi điều kiện này tùy thuộc vào cách kiểm tra của bạn
  }

  bool _isDocumentsTabComplete() {
    // Kiểm tra các trường thông tin trong tab "Tài liệu"
    // Ví dụ: Kiểm tra xem các file đã được chọn hay chưa
    return true; // Thay đổi điều kiện này tùy thuộc vào cách kiểm tra của bạn
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
              onPressed: (_isInformationComplete &&
                      _isVersionComplete &&
                      _isDocumentsComplete)
                  ? () {
                      // Thực hiện hành động lưu
                    }
                  : null,
              child: Text(
                'Lưu',
                style: TextStyle(
                  color: (_isInformationComplete &&
                          _isVersionComplete &&
                          _isDocumentsComplete)
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
            VersionTab(),
            DocumentsTab(onFileSelected: _checkCompletion),
          ],
        ),
      ),
    );
  }
}

// Tab Thông tin
class InformationTab extends StatefulWidget {
  const InformationTab({Key? key}) : super(key: key);

  @override
  _InformationTabState createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  String? _status;

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    _dateController.addListener(_checkCompletion);
    _infoController.addListener(_checkCompletion);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _infoController.dispose();
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
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
        _checkCompletion();
      });
    }
  }

  void _checkCompletion() {
    final addTopicState = context.findAncestorStateOfType<_CreateTopicScreenState>();
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

// Tab Thành viên
class VersionTab extends StatefulWidget {
  const VersionTab({Key? key}) : super(key: key);

  @override
  _VersionTabState createState() => _VersionTabState();
}

class _VersionTabState extends State<VersionTab> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  List<Widget> _members = []; // Danh sách thành viên
  int _memberCount = 0; // Biến đếm số lượng thành viên

  @override
  void initState() {
    super.initState();
    // Thêm listener cho controllers
    _dateController.addListener(_checkCompletion);
    _infoController.addListener(_checkCompletion);

    // Thêm phần thành viên đầu tiên khi vào trang
    _addMember(); // Đưa vào đây để tạo bảng đầu tiên ngay khi khởi tạo
  }

  @override
  void dispose() {
    _dateController.dispose();
    _infoController.dispose();
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
        _dateController.text = "${selectedDate.toLocal()}"
            .split(' ')[0]; // Cập nhật văn bản với ngày đã chọn
        _checkCompletion(); // Kiểm tra trạng thái khi ngày thay đổi
      });
    }
  }

  void _checkCompletion() {
    final addTopicState = context.findAncestorStateOfType<_CreateTopicScreenState>();
    addTopicState?._checkCompletion();
  }

  void _addMember() {
    setState(() {
      _members.add(
        _buildMember(_memberCount),
      );
      _memberCount++;
    });
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
              icon: Icon(Icons.do_not_disturb_on,
                  color: _members.length > 1 ? Colors.red : Colors.grey),
              onPressed:
                  _members.length > 1 ? () => _removeMember(index) : null,
            ),
          ],
        ),
        SizedBox(height: 16),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Đinh danh',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Vai trò',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        // Đường line phân chia giữa các bảng
        if (_members.length > 1 && index < _members.length - 1)
          Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  void _removeMember(int index) {
    if (_members.isNotEmpty) {
      setState(() {
        _members.removeAt(index);
        _memberCount--; // Giảm số lượng thành viên
        // Cập nhật lại số thứ tự các thành viên còn lại
        _updateMemberLabels();
      });
    }
  }

  void _updateMemberLabels() {
    setState(() {
      _members = List.generate(_memberCount, (index) => _buildMember(index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị danh sách thành viên
          ..._members,

          // Đường line màu xám ở dưới cùng
          if (_members.isNotEmpty) SizedBox(height: 10),
          if (_members.isNotEmpty) Divider(color: Colors.grey, thickness: 1),

          // Icon add và chữ Thêm
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
  }
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
