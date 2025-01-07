import 'package:flutter/material.dart';
import 'package:home/authentication/enter_otp_screen.dart';
import 'package:home/authentication/login_screen.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/utils/toast_utils.dart';

import '../base/api_url.dart';
import '../constants/text_style.dart';
import '../models/send_otp_response.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ChangePasswordScreen({super.key, required this.email, required this.otp});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with BaseLoadingState{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? _newPassword;

  void _submitForm(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      showLoading(); // Show the loading indicator

      // Lấy dữ liệu từ form
      final email = widget.email;

      // Tạo payload cho yêu cầu HTTP
      final Map<String, dynamic> body = {
        'mail': email,
        "otp": widget.otp,
        "newPass" : _newPassword
      };

      try {
        final data = await apiService.post(
          ApiUrl.post_reset_password(),
          body: body,
        );

        hideLoading(); // Hide the loading indicator

        SendOtpResponse response = SendOtpResponse.fromJson(data);
        if (response.message?.isNotEmpty ?? false) {
          ToastUtils.showSuccess("Mật khẩu của bạn đã được thay đổi thành công! Bạn có thể sử dụng mật khẩu mới để đăng nhập.");
          Navigator.pop(context, true);
        }
      } catch (e, stackTrace) {
        print(stackTrace);
        hideLoading(); // Hide the loading indicator in case of an error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Track whether the keyboard is visible
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return buildWithLoading(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            // Provide a valid email value for EnterOTP
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EnterOTPScreen(email: 'example@example.com')), // Provide a valid email here
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isKeyboardVisible) ...[
              const SizedBox(height: 1),
              Center(
                child: Image.asset(
                  'assets/images/lock.png',
                  height: 145,
                  width: 159,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 50),
            ],
            SizedBox(height: isKeyboardVisible ? 10 : 0),
            const Text(
              'Đặt lại mật khẩu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Mật khẩu chứa từ 8 đến 32 ký tự, bao gồm chữ và số',
              style: const TextStyle(
                color: Color(0xFF626262), fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    obscureText: obscurePassword,
                    obscuringCharacter: '*',
                    onChanged: (value) {
                      setState(() {
                        _newPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      } else if (value.length < 8) {
                        return 'Mật khẩu phải chứa ít nhất 8 ký tự';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nhập mật khẩu mới',
                      hintText: 'Nhập mật khẩu mới của bạn',
                      hintStyle: const TextStyle(color: Colors.black54),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 17),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorStyle: errorStyle,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: obscureConfirmPassword,
                    obscuringCharacter: '*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu';
                      } else if (value != _newPassword) {
                        return 'Mật khẩu nhập lại không khớp';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu mới',
                      hintText: 'Nhập lại mật khẩu mới của bạn',
                      hintStyle: const TextStyle(color: Colors.black54),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 17),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorStyle: errorStyle,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text(
                        'Đặt lại mật khẩu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
