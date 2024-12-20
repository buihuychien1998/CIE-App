import 'package:flutter/material.dart';

class InformationTopic extends StatefulWidget {
  @override
  _InformationTopicState createState() => _InformationTopicState();
}

class _InformationTopicState extends State<InformationTopic> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController(text: 'Tên đề tài');
  TextEditingController _codeController = TextEditingController(text: 'Mã số');
  TextEditingController _typeController = TextEditingController(text: 'Loại hình');
  TextEditingController _unitController = TextEditingController(text: 'Đơn vị');
  TextEditingController _managementController = TextEditingController(text: 'Cấp quản lý');
  TextEditingController _fundingController = TextEditingController(text: 'Kinh phí');
  TextEditingController _yearController = TextEditingController(text: 'Năm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Thông tin đề tài',
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
                  // Mục Tên đề tài
                  Text(
                    'Tên đề tài',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 42,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _nameController,
                      enabled: _isEditing,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _typeController,
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _unitController,
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

                  // Mục cấp quản lý
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _managementController,
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

                  // Mục kinh phí
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _fundingController,
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

                  // Mục năm
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
                        child: Container(
                          constraints: BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _yearController,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
