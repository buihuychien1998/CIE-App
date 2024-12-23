import 'package:flutter/material.dart';

import '../models/topic_response.dart';

class TopicMemberScreen extends StatefulWidget {
  final Topic topic;

  const TopicMemberScreen({super.key, required this.topic});

  @override
  _TopicMemberScreenState createState() => _TopicMemberScreenState();
}

class _TopicMemberScreenState extends State<TopicMemberScreen> {
  // Assuming that Topic has a List<Student> called students
  late List<Student> _students;

  @override
  void initState() {
    super.initState();
    // Fetch or initialize the students list from the topic
    _students = widget.topic.student ?? []; // Assuming widget.topic.students is the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Danh sách thành viên',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            color: Colors.grey[300],
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Horizontal scrolling for the table
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 20.0, // Column spacing
                  columns: [
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 20),
                        child: Text('TT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text('Họ và tên', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text('Mã định danh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text('Chức vụ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                  ],
                  rows: _students.asMap().entries.map((entry) {
                    int index = entry.key;
                    Student student = entry.value;
                    return DataRow(cells: [
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 20),
                          child: Text('${index + 1}', overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(student.fullname ?? "", overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(student.studentCode ?? "", overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(student.positionName ?? "",  overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

