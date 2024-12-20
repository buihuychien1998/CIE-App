import 'package:flutter/material.dart';

class ReportVersionScreen extends StatefulWidget {
  const ReportVersionScreen({super.key});

  @override
  _ReportVersionScreenState createState() => _ReportVersionScreenState();
}

class _ReportVersionScreenState extends State<ReportVersionScreen> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController(text: 'Tên tờ trình');
  TextEditingController _codeController = TextEditingController(text: 'Mã số');
  TextEditingController _dateController = TextEditingController(text: 'Ngày');
  TextEditingController _signerController = TextEditingController(text: 'Người ký');
  TextEditingController _fwdController = TextEditingController(text: 'FWD');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Phiên bản tờ trình', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                // Mục Tên tờ trình
                Text(
                  'Tên tờ trình',
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
                          enabled: _isEditing, // Chỉ cho phép chỉnh sửa khi _isEditing là true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Nhập mã số',
                          ),
                          style: TextStyle(fontSize: 14),
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
                          controller: _dateController,
                          enabled: _isEditing,
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

                // Mục Người ký
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Người ký',
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
                            hintText: 'Nhập người ký',
                          ),
                          style: TextStyle(fontSize: 14),
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
                            hintText: 'Nhập FWD',
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
