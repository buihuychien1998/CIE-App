import 'package:flutter/material.dart';
import 'package:home/authentication/enter_otp_screen.dart';
import 'package:home/authentication/login_screen.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/extension/string_extension.dart';

import '../base/api_url.dart';
import '../constants/text_style.dart';
import '../models/send_otp_response.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> with WidgetsBindingObserver, BaseLoadingState {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  String? _email;
  bool _isEmailFocused = false;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final keyboardVisibility = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    setState(() {
      _isKeyboardVisible = keyboardVisibility;
    });
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      showLoading(); // Show the loading indicator

      // Lấy dữ liệu từ form
      final email = _email;

      // Tạo payload cho yêu cầu HTTP
      final Map<String, dynamic> body = {
        'mail': email,
      };

      try {
        final data = await apiService.post(
          ApiUrl.post_send_otp(),
          body: body,
        );

        hideLoading(); // Hide the loading indicator

        SendOtpResponse response = SendOtpResponse.fromJson(data);
        if (response.message?.isNotEmpty ?? false) {
          bool result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterOTPScreen(email: _email!), // Truyền email vào đây
            ),
          );
          if(result){
            Navigator.pop(context);
          }
        }
      } catch (e, stackTrace) {
        print(stackTrace);
        hideLoading(); // Hide the loading indicator in case of an error
      }
    }
  }



  bool get _isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isKeyboardVisible) ...[
                const SizedBox(height: 1),
                Center(
                  child: Image.asset(
                    'assets/images/forget.png',
                    height: 174,
                    width: 156,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 50),
              ],
              SizedBox(height: _isKeyboardVisible ? 10 : 0),
              const Text(
                'Quên mật khẩu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Vui lòng nhập email liên kết với tài khoản của bạn để nhập mã xác minh',
                style: TextStyle(
                  color: Color(0xFF626262), fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      focusNode: _emailFocusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email không được để trống.';
                        } else if (!value.trim().isValidEmail()) {
                          return 'Email không hợp lệ.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Nhập email của bạn',
                        hintStyle: const TextStyle(color: Colors.grey),
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
                      ),
                    ),
                    const SizedBox(height: 60),
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
            ],
          ),
        ),
      ),
    ));
  }
}
