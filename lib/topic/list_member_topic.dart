import 'package:flutter/material.dart';

class ListMemberTopic extends StatefulWidget {
  @override
  _ListMemberTopicState createState() => _ListMemberTopicState();
}

class _ListMemberTopicState extends State<ListMemberTopic> {
  final List<Map<String, String>> _members = [
    {'name': 'Hoàng Hữu Hạnh', 'id': '123456', 'position': 'Chủ trì'},
    {'name': 'Phạm Vũ Minh Tú', 'id': '234567', 'position': 'Thành viên'},
    {'name': 'Phạm Trần Cẩm Vân', 'id': '345678', 'position': 'Thành viên'},
    {'name': 'Nguyễn Ngọc Linh', 'id': '456789', 'position': 'Thành viên'},
    {'name': 'Lê Thị Thúy Hà', 'id': '456789', 'position': 'Thành viên'},
  ];

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
      SizedBox(height: 10,),
      Expanded(
        child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Thêm cuộn ngang cho bảng
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 20.0, // Khoảng cách giữa các cột
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
            rows: _members.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> member = entry.value;
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
                    child: Text(member['name'] ?? '', overflow: TextOverflow.ellipsis),
                  ),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 150),
                    child: Text(member['id'] ?? '', overflow: TextOverflow.ellipsis),
                  ),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 150),
                    child: Text(member['position'] ?? '', overflow: TextOverflow.ellipsis),
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
