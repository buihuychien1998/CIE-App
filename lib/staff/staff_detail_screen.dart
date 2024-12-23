import 'package:flutter/material.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:home/models/employee_response.dart';
import 'package:home/report/report_screen.dart';
import 'package:home/staff/staff_screen.dart';
import 'package:home/staff/staff_recruitment_screen.dart';
import 'package:home/staff/personal_doc.dart';
import 'package:home/staff/staff_personal_information_screen.dart';

class StaffDetailScreen extends StatefulWidget {
  late Employee staff;

  StaffDetailScreen({super.key, required this.staff});

  @override
  _StaffDetailScreenState createState() => _StaffDetailScreenState();
}

class _StaffDetailScreenState extends State<StaffDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
          child: Text(
            'Hồ sơ nhân viên ${widget.staff.employCode}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async{
                  final updatedStaff = await Navigator.push<Employee>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaffPersonalInformationScreen(employee: widget.staff),
                    ),
                  );

                  // If the updated topic is not null, update the current model
                  if (updatedStaff != null) {
                    setState(() {
                      widget.staff = updatedStaff;  // Update the original topic with the updated one
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 13),
                  constraints: BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thông tin cá nhân',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  final updatedStaff = await Navigator.push<Employee>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaffRecruitmentScreen(employee: widget.staff),
                    ),
                  );

                  // If the updated topic is not null, update the current model
                  if (updatedStaff != null) {
                    setState(() {
                      widget.staff = updatedStaff;  // Update the original topic with the updated one
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thông tin tuyển dụng',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalDocument(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tài liệu cá nhân',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
