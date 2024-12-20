import 'package:flutter/material.dart';
import 'package:home/document_viewer_page.dart';

class FileTopic extends StatelessWidget {
  final String unsignedFile = 'path/to/unsigned_file.pdf';
  final String reportFile = 'path/to/report_file.doc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hồ sơ thực hiện', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {
              // Thêm chức năng chỉnh sửa khi nhấn vào biểu tượng bút
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mục "Thuyết minh"
                Text(
                  'Thuyết minh',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentViewerPage(
                          filePath: unsignedFile,
                          fileType: 'pdf',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border.all(
                        color: Color(0xFFF4F4F4),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Xem thuyết minh',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Mục "Đề cương"
                Text(
                  'Đề cương',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentViewerPage(
                          filePath: reportFile,
                          fileType: 'doc',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border.all(
                        color: Color(0xFFF4F4F4),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Xem đề cương',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Mục "Báo cáo"
                Text(
                  'Báo cáo',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentViewerPage(
                          filePath: reportFile,
                          fileType: 'doc',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border.all(
                        color: Color(0xFFF4F4F4),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Xem báo cáo',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: FileTopic(),
  ));
}
