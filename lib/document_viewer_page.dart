import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';

class DocumentViewerPage extends StatelessWidget {
  final String filePath;
  final String fileType; // "pdf", "doc", hoặc "docx"

  DocumentViewerPage({required this.filePath, required this.fileType});

  Future<bool> _checkFileValidity(String path) async {
    final result = await OpenFile.open(path);
    return result.type == ResultType.done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: Offset(75, 0),
          child: Text(
            'Xem tài liệu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 4,
            color: Colors.grey[300],
            width: double.infinity,
          ),
          Expanded(
            child: FutureBuilder<bool>(
              future: _checkFileValidity(filePath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == false) {
                  return Center(
                    child: Text(
                      'Không thể mở file.',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return fileType == 'pdf'
                      ? PDFView(filePath: filePath)
                      : Center(
                    child: Text(
                      'Không thể hiển thị file DOC tại đây.',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
