import 'package:flutter/material.dart';
import 'package:home/models/proposal_response.dart';
import 'package:home/report/report_information_screen.dart';
import 'package:home/report/report_version_screen.dart';
import 'package:home/report/doc_report.dart';

class ReportDetailScreen extends StatefulWidget {
  late Proposal proposal;

  ReportDetailScreen({super.key, required this.proposal});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
          child: Text(
            'Tờ trình số ${widget.proposal.proposalCode ?? ""}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                  final updatedProposal = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportInformationScreen(proposal: widget.proposal,),
                    ),
                  );

                  setState(() {
                    widget.proposal = updatedProposal;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: const BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thông tin tờ trình',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF272727)),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFB0B0B0),),
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
                      builder: (context) => ReportVersionScreen(proposal: widget.proposal,),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: const BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phiên bản tờ trình',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF272727)),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFB0B0B0),),
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
                      builder: (context) => DocumentReport(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: const BoxConstraints(minHeight: 48),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tài liệu tờ trình',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF272727)),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFB0B0B0),),
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
