import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';

import '../base/api_url.dart';
import '../models/proposal_create_response.dart' as proposalUpdate;
import '../models/proposal_response.dart';
import '../models/proposal_update_request.dart';
import '../utils/toast_utils.dart';

class ReportInformationScreen extends StatefulWidget {
  late Proposal proposal;

  ReportInformationScreen({super.key, required this.proposal});

  @override
  _ReportInformationScreenState createState() =>
      _ReportInformationScreenState();
}

class _ReportInformationScreenState extends State<ReportInformationScreen>
    with BaseLoadingState {
  bool _isEditing = false;
  var maxLines = 5;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _signerController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.proposal.nameProposal ?? "";
    // _nameController.text =  "v/v Kế hoạch tổ chức đào tạo học kỳ II năm học 2023 - 2024 cho lớp LKĐT và cấp bằng cử nhân CNTT giữa Học viện CNBCVT và ĐH La Trobe ( Úc) khóa 2022 - 2023";
    _codeController.text = widget.proposal.proposalCode ?? "";
    _dateController.text = widget.proposal.dateCreated ?? "";
    _signerController.text = widget.proposal.signer ?? "";
    _statusController.text =
        widget.proposal.status == true ? "Đã ký" : "Chưa ký";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Thông tin tờ trình',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
          Container(
            margin: const EdgeInsets.only(
              right: 16,
            ),
            child: InkWell(
              onTap: () {
                updateProposal();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Lưu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ),
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mục Tên tờ trình
                  const Text(
                    'Tên tờ trình',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _nameController,
                      enabled: _isEditing,
                      maxLines: maxLines,
                      minLines: maxLines,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF272727)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mục Mã số
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Mã số',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _codeController,
                            enabled: false,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: InputBorder.none,
                            ),
                            // style: const TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //     color: Color(0xFF272727)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Mục Ngày
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Ngày',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _dateController,
                            enabled: _isEditing,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF272727)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Mục Người ký
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Người ký',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _signerController,
                            enabled: _isEditing,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF272727)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Mục trạng thái
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Trạng thái',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 42),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _statusController,
                            enabled: _isEditing,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.proposal.status == true
                                    ? Color(0xFF44B971)
                                    : Color(0xFFFC4D4D)),
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

  Future<void> updateProposal() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      Proposal proposal = widget.proposal;
      proposal.nameProposal = _nameController.text;
      proposal.proposalCode = _codeController.text;
      proposal.dateCreated = _dateController.text;
      proposal.signer = _signerController.text;
      proposal.status = _statusController.text == "Đã ký" ? true : false;
      // _nameController.text =  "v/v Kế hoạch tổ chức đào tạo học kỳ II năm học 2023 - 2024 cho lớp LKĐT và cấp bằng cử nhân CNTT giữa Học viện CNBCVT và ĐH La Trobe ( Úc) khóa 2022 - 2023";
      final body = ProposalUpdateRequest();
      body.dataUpdate = DataUpdate.fromJson(proposal.toJson());
      body.proposalCode = widget.proposal.proposalCode;
      final data = await apiService.post(ApiUrl.post_update_proposal(),
          body: body.toJson());

      proposalUpdate.ProposalCreateResponse response = proposalUpdate.ProposalCreateResponse.fromJson(data);
      if (response.proposal?.id != null) {
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
