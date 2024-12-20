import 'package:flutter/material.dart';

class EmploymentInformation extends StatefulWidget {
  @override
  _EmploymentInformationState createState() => _EmploymentInformationState();
}

class _EmploymentInformationState extends State<EmploymentInformation> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController(text: 'Ngày');
  TextEditingController _codeController = TextEditingController(text: 'Ngày');
  TextEditingController _dateController = TextEditingController(text: 'Bậc');
  TextEditingController _signerController = TextEditingController(text: 'Hệ số');
  TextEditingController _fwdController = TextEditingController(text: 'Phụ cấp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin tuyển dụng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                // Mục Ngày tuyển
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
                          controller: _nameController,
                          enabled: _isEditing, // Chỉ cho phép chỉnh sửa khi _isEditing là true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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

                // Mục ngày huởng
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
                          controller: _codeController,
                          enabled: _isEditing, // Chỉ cho phép chỉnh sửa khi _isEditing là true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _dateController,
                          enabled: _isEditing,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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

                // Mục hệ số
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
                          controller: _signerController,
                          enabled: _isEditing,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
                      child: Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _fwdController,
                          enabled: _isEditing, // Chỉ cho phép chỉnh sửa khi _isEditing là true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
}
