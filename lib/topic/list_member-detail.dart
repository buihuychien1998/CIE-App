import 'package:flutter/material.dart';

class ListMemberDetail extends StatefulWidget {
  @override
  _ListMemberDetailState createState() => _ListMemberDetailState();
}

class _ListMemberDetailState extends State<ListMemberDetail> {
  bool _isEditing = false;
  TextEditingController _codeController = TextEditingController(text: 'Tên');
  TextEditingController _dateController = TextEditingController(text: 'Mã định danh');
  TextEditingController _signerController = TextEditingController(text: 'Đơn vị');
  TextEditingController _fwdController = TextEditingController(text: 'Vai trò');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Phiên bản tờ trình'),
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
                // Mục họ tên
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
                          controller: _codeController,
                          enabled: _isEditing, // Chỉ cho phép chỉnh sửa khi _isEditing là true
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Tên',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Mục Định danh
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Định danh',
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
                            hintText: 'Mã định danh',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Mục đơn vị
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
                          controller: _signerController,
                          enabled: _isEditing,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: 'Đơn vị',
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Mục vai trò
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
                            hintText: 'Vai trò',
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
