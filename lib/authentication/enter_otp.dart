import 'dart:async'; // Để sử dụng Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/authentication/forget_password.dart';
import 'package:home/authentication/change_password.dart';

class EnterOTP extends StatefulWidget {
  final String email; // Thêm thuộc tính email

  EnterOTP({Key? key, required this.email}) : super(key: key);

  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  late Timer _timer;
  int _start = 120;
  bool _isResendEnabled = false;
  bool _isCountdownVisible = true;
  bool _isKeyboardVisible = false;

  bool get _isFormValid {
    // Kiểm tra nếu tất cả các trường OTP đều đã được nhập
    return _otpControllers.every((controller) => controller.text.length == 1);
  }

  void _startTimer() {
    _start = 120;
    _isResendEnabled = false;
    _isCountdownVisible = true; // Hiển thị số đếm ngược khi bắt đầu
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {
          _isResendEnabled = true;
          _isCountdownVisible = false; // Ẩn số đếm ngược khi về 0
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendCode() {
    if (_isResendEnabled) {
      _startTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer(); // Bắt đầu bộ đếm ngược khi trang được tạo
  }

  @override
  void dispose() {
    // Giải phóng các controller khi không còn sử dụng
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _timer.cancel(); // Hủy timer khi không còn sử dụng
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('OTP đã được xác nhận thành công'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePassword()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgetPassword()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isKeyboardVisible) ...[
                const SizedBox(height: 1),
                Center(
                  child: Image.asset(
                    'assets/images/maso.png',
                    height: 170,
                    width: 153,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 50),
              ],
              SizedBox(height: isKeyboardVisible ? 10 : 0),
              const Text(
                'Nhập mã xác minh',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Mã xác minh OTP đã được gửi tới email\n${widget.email}. Vui lòng nhập mã.',
                style: const TextStyle(
                  color: Color(0xFF626262), fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 67,
                      height: 67,
                      child: TextFormField(
                        controller: _otpControllers[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '', // Ẩn số ký tự đếm
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _otpControllers[index].text.isNotEmpty ? Colors.blueAccent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _otpControllers[index].text.isNotEmpty ? Colors.blueAccent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _otpControllers[index].text.isNotEmpty ? Colors.blueAccent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép nhập số
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            // Tự động chuyển sang ô tiếp theo khi nhập xong
                            if (index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          } else {
                            // Tự động chuyển về ô trước đó khi xóa
                            if (index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          }
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nhập mã';
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bạn chưa nhận được mã?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Gửi lại ',
                            style: TextStyle(
                              color: _isResendEnabled ? Colors.blueAccent : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: _isCountdownVisible ? '(${_start}s)' : '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid ? () => _submitForm(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? Colors.blueAccent : Colors.grey,
                  ),
                  child: const Text(
                    'Tiếp tục',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
