import 'package:flutter/material.dart';
import 'package:home/models/topic_update_response.dart' as topicUpdate;

import '../base/api_url.dart';
import '../base/base_loading_state.dart';
import '../models/topic_response.dart';
import '../models/topic_update_request.dart';
import '../utils/toast_utils.dart';

class TopicInformationScreen extends StatefulWidget {
  final Topic topic;

  const TopicInformationScreen({super.key, required this.topic});

  @override
  _TopicInformationScreenState createState() => _TopicInformationScreenState();
}

class _TopicInformationScreenState extends State<TopicInformationScreen> with BaseLoadingState {
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _typeController;
  late TextEditingController _unitController;
  late TextEditingController _managementController;
  late TextEditingController _fundingController;
  late TextEditingController _yearController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with data from the topic object
    _nameController = TextEditingController(text: widget.topic.nameTopic ?? '');
    _codeController = TextEditingController(text: widget.topic.topicCode ?? '');
    _typeController = TextEditingController(text: widget.topic.type ?? '');
    _unitController = TextEditingController(text: widget.topic.unit ?? '');
    _managementController = TextEditingController(
        text: widget.topic.levelManager ?? '');
    _fundingController = TextEditingController(text: widget.topic.burget ?? '');
    _yearController = TextEditingController(text: widget.topic.year ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _codeController.dispose();
    _typeController.dispose();
    _unitController.dispose();
    _managementController.dispose();
    _fundingController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Thông tin đề tài',
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
          Container(
            margin: const EdgeInsets.only(
              right: 16,
            ),
            child: InkWell(
              onTap: !_areAllFieldsEmpty() ? () { updateTopic(); } : null, // Disable onTap if all fields are empty
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Lưu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !_areAllFieldsEmpty() ? Colors.blue : Colors.grey), // Change color to grey if disabled
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildEditableField('Tên đề tài', _nameController),
              buildEditableField('Mã số', _codeController),
              buildEditableField('Loại hình', _typeController),
              buildEditableField('Đơn vị', _unitController),
              buildEditableField('Cấp quản lý', _managementController),
              buildEditableField('Kinh phí', _fundingController),
              buildEditableField('Năm', _yearController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    // Disable the input for 'Loại hình' and 'Cấp quản lý'
    bool isFieldDisabled = label == 'Mã số' || label == 'Loại hình' || label == 'Cấp quản lý';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(minHeight: 42),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            enabled: _isEditing && !isFieldDisabled,  // Disable if the field is marked
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Helper method to check if all fields are empty
  bool _areAllFieldsEmpty() {
    return _nameController.text.isEmpty &&
        _codeController.text.isEmpty &&
        _typeController.text.isEmpty &&
        _unitController.text.isEmpty &&
        _managementController.text.isEmpty &&
        _fundingController.text.isEmpty &&
        _yearController.text.isEmpty;
  }

  Future<void> updateTopic() async {
    showLoading();
    // Lấy dữ liệu từ form
    try {
      // Create a DataUpdate object and set its fields from the controllers
      DataUpdate dataUpdate = DataUpdate(
        nameTopic: _nameController.text,
        topicCode: _codeController.text,
        type: _typeController.text,
        unit: _unitController.text,
        levelManager: _managementController.text,
        burget: _fundingController.text,
        year: _yearController.text,
      );

      // Create a TopicUpdateRequest object and assign the DataUpdate
      final body = TopicUpdateRequest(
        topicCode: widget.topic.topicCode,
        dataUpdate: dataUpdate,
      );

      // Send the request to update the topic
      final data = await apiService.post(
        ApiUrl.post_update_topic(),
        body: body.toJson(),
      );

      topicUpdate.TopicUpdateResponse response = topicUpdate.TopicUpdateResponse.fromJson(data);
      if (response.topic?.id != null) {
        ToastUtils.showSuccess("Bạn đã cập nhật đề tài thành công!");

        // Update the topic with new values
        setState(() {
          widget.topic.nameTopic = _nameController.text;
          widget.topic.topicCode = _codeController.text;
          widget.topic.type = _typeController.text;
          widget.topic.unit = _unitController.text;
          widget.topic.levelManager = _managementController.text;
          widget.topic.burget = _fundingController.text;
          widget.topic.year = _yearController.text;
        });

        // Return the updated topic to the previous screen
        Navigator.pop(context, widget.topic);  // Pass the updated topic back
      } else {
        ToastUtils.showError(
            "Cập nhật đề tài không thành công. Vui lòng kiểm tra và thử lại!");
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

}

