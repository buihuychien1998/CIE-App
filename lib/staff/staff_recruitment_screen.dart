import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/extension/string_extension.dart';
import 'package:home/models/employee_response.dart';

import '../base/api_url.dart';
import '../models/staff_update_request.dart';
import '../models/staff_update_response.dart' as staffUpdate;
import '../utils/toast_utils.dart';

class StaffRecruitmentScreen extends StatefulWidget {
  late Employee employee;

  StaffRecruitmentScreen({super.key, required this.employee});

  @override
  _StaffRecruitmentScreenState createState() => _StaffRecruitmentScreenState();
}

class _StaffRecruitmentScreenState extends State<StaffRecruitmentScreen>
    with BaseLoadingState {
  bool _isEditing = false;

  // Rename controllers to match the corresponding data
  TextEditingController _dateJoinController = TextEditingController();
  TextEditingController _paydayController = TextEditingController();
  TextEditingController _levelSalaryController = TextEditingController();
  TextEditingController _multiplierController = TextEditingController();
  TextEditingController _extendSalaryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Check if the employee data is available, otherwise use empty strings
    _dateJoinController.text = widget.employee.dateJoin ?? '';
    _paydayController.text = widget.employee.payday ?? '';
    _levelSalaryController.text = widget.employee.levelSalary ?? '';
    _multiplierController.text = widget.employee.multiplier ?? '';
    _extendSalaryController.text = widget.employee.extendSalary ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Thông tin tuyển dụng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
      body: Column(
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
                // Ngày tuyển
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _dateJoinController,
                          enabled: _isEditing,
                          // Only allow editing when _isEditing is true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập ngày',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Ngày hưởng
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _paydayController,
                          enabled: _isEditing,
                          // Only allow editing when _isEditing is true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập ngày',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Bậc lương
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _levelSalaryController,
                          enabled: _isEditing,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập bậc lương',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Hệ số
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _multiplierController,
                          enabled: _isEditing,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập hệ số',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Phụ cấp
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _extendSalaryController,
                          enabled: _isEditing,
                          // Only allow editing when _isEditing is true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập phụ cấp',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get _isSaveButtonEnabled {
    return !TextUtils.isEmpty(_levelSalaryController.text) &&
        !TextUtils.isEmpty(_multiplierController.text);
  }

  Future<void> updateStaff() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      // Create a DataUpdate object and set its fields from the controllers
      DataUpdate dataUpdate = DataUpdate(
        fullname: widget.employee.fullname,
        employCode: widget.employee.employCode,
        position: widget.employee.position,
        birthday: widget.employee.birthday,
        idCardNumber: widget.employee.idCardNumber,
        socialCode: widget.employee.socialCode,
        address: widget.employee.address,
        education: widget.employee.education,
        level: widget.employee.level,
        foreignLang: widget.employee.foreignLang,
        itLevel: widget.employee.itLevel,
        joinClan: widget.employee.joinClan,
        dateJoin: _dateJoinController.text,
        payday: _paydayController.text,
        levelSalary: _levelSalaryController.text,
        multiplier: _multiplierController.text,
        extendSalary: _extendSalaryController.text,
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

      staffUpdate.StaffUpdateResponse response =
          staffUpdate.StaffUpdateResponse.fromJson(data);
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
        ToastUtils.showError(
            "Cập nhật nhân sự không thành công. Vui lòng kiểm tra và thử lại!");
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
