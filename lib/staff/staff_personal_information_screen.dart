import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/models/employee_response.dart';
import 'package:home/models/staff_update_response.dart' as staffUpdate;

import '../base/api_url.dart';
import '../extension/string_extension.dart';
import '../models/staff_update_request.dart';
import '../utils/toast_utils.dart';

class StaffPersonalInformationScreen extends StatefulWidget {
  late Employee employee;
  StaffPersonalInformationScreen({super.key, required this.employee});

  @override
  _StaffPersonalInformationScreenState createState() => _StaffPersonalInformationScreenState();
}

class _StaffPersonalInformationScreenState extends State<StaffPersonalInformationScreen> with BaseLoadingState{
  bool _isEditing = false;

  // Initialize controllers with values only if they are not null
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _CCCDnumberController = TextEditingController();
  final TextEditingController _BHXHnumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _computerController = TextEditingController();
  final TextEditingController _CSVNdateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set initial values from the Employee model if available
    _nameController.text = widget.employee.fullname ?? '';
    _positionController.text = widget.employee.position ?? '';
    _codeController.text = widget.employee.employCode ?? '';
    _dateofbirthController.text = widget.employee.birthday ?? '';
    _CCCDnumberController.text = widget.employee.idCardNumber ?? '';
    _BHXHnumberController.text = widget.employee.socialCode ?? '';
    _placeController.text = widget.employee.address ?? '';
    _educationController.text = widget.employee.education ?? '';
    _qualificationController.text = widget.employee.level ?? '';
    _languageController.text = widget.employee.foreignLang ?? '';
    _computerController.text = widget.employee.itLevel ?? '';
    _CSVNdateController.text = widget.employee.joinClan ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin cá nhân', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Image.asset(
                "assets/images/ic_edit.png",
                color: _isEditing ? Colors.blue : const Color(0xFF272727),
                height: 18,
                width: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 16,
            ),
            child: InkWell(
              onTap: _isSaveButtonEnabled ? () => updateStaff() : null,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Lưu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isSaveButtonEnabled ? Colors.blue : Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 3,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Họ tên
                  _buildTextFieldRow('Họ tên', _nameController),
                  // Chức vụ
                  _buildTextFieldRow('Chức vụ', _positionController),
                  // Mã NV
                  _buildTextFieldRow('Mã NV', _codeController, isEnabled: false),
                  // Ngày sinh
                  _buildTextFieldRow('Ngày', _dateofbirthController),
                  // Số CCCD
                  _buildTextFieldRow('Số CCCD', _CCCDnumberController),
                  // Số BHXH
                  _buildTextFieldRow('Số BHXH', _BHXHnumberController),
                  // Nơi ở
                  _buildTextFieldRow('Nơi ở', _placeController),
                  Divider(color: Colors.grey, thickness: 2.0),
                  // Học vấn
                  _buildTextFieldRow('Học vấn', _educationController),
                  // Trình độ
                  _buildTextFieldRow('Trình độ', _qualificationController),
                  // Ngoại ngữ
                  _buildTextFieldRow('Ngoại ngữ', _languageController),
                  // Tin học
                  _buildTextFieldRow('Tin học', _computerController),
                  // Ngày vào ĐCSVN
                  _buildTextFieldRow('Ngày vào ĐCSVN', _CSVNdateController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create the row layout for text fields
  Widget _buildTextFieldRow(String label, TextEditingController controller, {bool isEnabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
            child: Container(
              constraints: BoxConstraints(minHeight: 42),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: TextField(
                controller: controller,
                enabled: _isEditing && isEnabled,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _isSaveButtonEnabled {
    return !TextUtils.isEmpty(_nameController.text) &&
        !TextUtils.isEmpty(_codeController.text) &&
        !TextUtils.isEmpty(_CCCDnumberController.text) &&
        !TextUtils.isEmpty(_positionController.text);
  }

  Future<void> updateStaff() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      // Create a DataUpdate object and set its fields from the controllers
      DataUpdate dataUpdate = DataUpdate(
        fullname: _nameController.text,
        employCode: widget.employee.employCode,
        position: _positionController.text,
        birthday: _dateofbirthController.text,
        idCardNumber: _CCCDnumberController.text,
        socialCode: _BHXHnumberController.text,
        address: _placeController.text,
        education: _educationController.text,
        level: _qualificationController.text,
        foreignLang: _languageController.text,
        itLevel: _computerController.text,
        joinClan: _CSVNdateController.text,
        dateJoin: widget.employee.dateJoin,
        payday: widget.employee.payday,
        levelSalary: widget.employee.levelSalary,
        multiplier: widget.employee.multiplier,
        extendSalary: widget.employee.extendSalary,
      );

      // Create a StaffUpdateRequest object and assign the DataUpdate
      final body = StaffUpdateRequest(
        employCode: widget.employee.employCode,
        dataUpdate: dataUpdate,
      );

      // Send the request to update the staff information
      final data = await apiService.post(
        ApiUrl.post_update_employee(),
        body: body.toJson(),
      );

      staffUpdate.StaffUpdateResponse response = staffUpdate.StaffUpdateResponse.fromJson(data);
      if (response.employee?.id != null) {
        ToastUtils.showSuccess("Bạn đã cập nhật nhân sự thành công!");

        // Update the origin model
        setState(() {
          widget.employee = Employee.fromJson(response.employee?.toJson());
        });

        // Navigate to the updated staff info screen
        Navigator.pop(
          context,
          widget.employee,
        );
      } else {
        ToastUtils.showError("Cập nhật nhân sự không thành công. Vui lòng kiểm tra và thử lại!");
      }
      if (response.employee?.id != null) {
        ToastUtils.showSuccess("Bạn đã cập nhật nhân sự thành công!");
      } else {
        ToastUtils.showError(
            "Cập nhật nhân sự không thành công. Vui lòng kiểm tra và thử lại!");
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

}