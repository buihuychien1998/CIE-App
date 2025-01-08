import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/models/proposal_response.dart';

import '../base/api_url.dart';
import '../models/proposal_create_response.dart' as proposalUpdate;
import '../models/proposal_update_request.dart';
import '../utils/toast_utils.dart';


class ReportVersionScreen extends StatefulWidget {
  late Proposal proposal;

  ReportVersionScreen({super.key, required this.proposal});

  @override
  _ReportVersionScreenState createState() => _ReportVersionScreenState();
}

class _ReportVersionScreenState extends State<ReportVersionScreen> with BaseLoadingState{
  bool _isEditing = false;
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _codeControllers;
  late List<TextEditingController> _dateControllers;
  late List<TextEditingController> _signerControllers;
  late List<TextEditingController> _fwdControllers;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the proposal versions data
    _nameControllers = widget.proposal.version?.map((v) => TextEditingController(text: v.nameVersion ?? '')).toList() ?? [];
    _codeControllers = widget.proposal.version?.map((v) => TextEditingController(text: v.proposalCode ?? '')).toList() ?? [];
    _dateControllers = widget.proposal.version?.map((v) => TextEditingController(text: v.dateVersionCreated ?? '')).toList() ?? [];
    _signerControllers = widget.proposal.version?.map((v) => TextEditingController(text: v.signerVersion ?? '')).toList() ?? [];
    _fwdControllers = widget.proposal.version?.map((v) => TextEditingController(text: v.fwd ?? '')).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Phiên bản tờ trình',
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
            InkWell(
              onTap: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Image.asset(
                  "assets/images/ic_edit.png",
                  color: _isEditing ? Colors.blue : const Color(0xFF272727),
                  height: 18,
                  width: 18,
                ),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(
            //     right: 16,
            //   ),
            //   child: InkWell(
            //     onTap: () {
            //       updateProposal();
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //       child: Text(
            //         "Lưu",
            //         style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: ListView.builder(
          itemCount: widget.proposal.version?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên tờ trình
                  Text('Tên tờ trình', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(minHeight: 42),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _nameControllers[index],
                      enabled: _isEditing, // or toggle based on editing state
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

                  // Mã số
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Mã số', style: TextStyle(fontSize: 16)),
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
                            controller: _codeControllers[index],
                            enabled: false, // or toggle based on editing state
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

                  // Ngày
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Ngày', style: TextStyle(fontSize: 16)),
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
                            controller: _dateControllers[index],
                            enabled: _isEditing, // or toggle based on editing state
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

                  // Người ký
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Người ký', style: TextStyle(fontSize: 16)),
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
                            controller: _signerControllers[index],
                            enabled: _isEditing, // or toggle based on editing state
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

                  // FWD
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('FWD', style: TextStyle(fontSize: 16)),
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
                            controller: _fwdControllers[index],
                            enabled: _isEditing, // or toggle based on editing state
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
            );
          },
        ),
      ),
    );
  }

  Future<void> updateProposal() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      Proposal proposal = widget.proposal;
      print("Update proposal: ${proposal.toJson()}");
      // _nameController.text =  "v/v Kế hoạch tổ chức đào tạo học kỳ II năm học 2023 - 2024 cho lớp LKĐT và cấp bằng cử nhân CNTT giữa Học viện CNBCVT và ĐH La Trobe ( Úc) khóa 2022 - 2023";
      final body = ProposalUpdateRequest();
      body.dataUpdate = DataUpdate.fromJson(proposal.toJson());
      body.proposalCode = widget.proposal.proposalCode;
      final data = await apiService.post(ApiUrl.post_update_proposal(),
          body: body.toJson());

      proposalUpdate.ProposalCreateResponse response = proposalUpdate.ProposalCreateResponse.fromJson(data);
      if (response.error == null) {
        ToastUtils.showSuccess("Bạn đã cập nhật tờ trình thành công!");
        // Update the origin model
        setState(() {
          widget.proposal = Proposal.fromJson(response.proposal?.toJson());
        });

        // Navigate to the updated staff info screen
        Navigator.pop(
          context,
          widget.proposal,
        );
      } else {
        ToastUtils.showError(
            "Cập nhật tờ trình không thành công. Vui lòng kiểm tra và thử lại!");
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }
}

