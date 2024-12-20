import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController(text: 'Họ tên');
  TextEditingController _positionController = TextEditingController(text: 'Chuyên viên');
  TextEditingController _codeController = TextEditingController(text: 'Mã số');
  TextEditingController _dateofbirthController = TextEditingController(text: 'Ngày');
  TextEditingController _CCCDnumberController = TextEditingController(text: '0123456789');
  TextEditingController _BHXHnumberController = TextEditingController(text: '1234567890');
  TextEditingController _placeController = TextEditingController(text: 'Học viện CNBCVT');
  TextEditingController _educationController = TextEditingController(text: '12/12');
  TextEditingController _qualificationController = TextEditingController(text: 'Đại học');
  TextEditingController _languageController = TextEditingController(text: 'Tiếng Anh B2');
  TextEditingController _computerController = TextEditingController(text: '-');
  TextEditingController _CSVNdateController = TextEditingController(text: 'Ngày vào Đảng CSVN');

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
          IconButton(
            icon: Icon(Icons.edit_outlined, color: _isEditing ? Colors.blue : Colors.grey),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _nameController,
                            enabled: _isEditing,
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _positionController,
                            enabled: _isEditing,
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _codeController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục Ngày sinh
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Ngày',
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
                            controller: _dateofbirthController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục số cccd
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _CCCDnumberController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục số bhxh
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _BHXHnumberController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục nơi ở
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _placeController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  Divider(
                    color: Colors.grey,
                    thickness: 2.0, // Độ dày của đường line
                  ),
                  SizedBox(height: 16),

                  // Mục học vấn
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _educationController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục trình độ
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _qualificationController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục ngôn ngữ
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _languageController,
                            enabled: _isEditing,
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _computerController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),

                  // Mục ngày vào ĐCSVN
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Ngày vào ĐCSVN',
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
                            controller: _CSVNdateController,
                            enabled: _isEditing,
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
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
