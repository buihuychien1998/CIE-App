import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home/base/api_url.dart';
import 'package:home/constants/secure_storage.dart';
import 'package:home/constants/text_style.dart';
import 'package:home/extension/string_extension.dart';
import 'package:home/authentication/forget_password.dart';
import 'package:home/home/dashboard_screen.dart';
import 'package:http/http.dart' as http;

import '../base/base_loading_state.dart';
import '../constants/size_constants.dart';
import '../models/sign_in_response.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BaseLoadingState {
  final GlobalKey<FormState> _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool obscurePassword = true;
  bool _isKeyboardVisible = false;
  String? _email;
  String? _password;
  bool _isFormValid = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _loadRememberedCredentials();
  }

  // Load saved credentials if "remember password" was enabled
  Future<void> _loadRememberedCredentials() async {
    final savedEmail = await getEmail();
    final savedPassword = await getPassword();
    final savedRemember = await isRememberPassword();

    if (savedRemember && savedEmail != null && savedPassword != null) {
      setState(() {
        _email = savedEmail;
        _password = savedPassword;
        rememberPassword = savedRemember;
        _isFormValid = true; // Set form as valid since credentials exist
      });
    }
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible =
          _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formSignInKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 500));
      showLoading(); // Show the loading indicator

      // Lấy dữ liệu từ form
      final email = _email;
      final password = _password;

      // Tạo payload cho yêu cầu HTTP
      final Map<String, dynamic> loginData = {
        'email': email,
        'password': password,
      };

      try {
        final data = await apiService.post(
          ApiUrl.post_login(),
          body: loginData,
        );
        await Future.delayed(const Duration(milliseconds: 500));
        print('Fetched users: $data');

        hideLoading(); // Hide the loading indicator

        // Save or clear credentials based on rememberPassword
        if (rememberPassword) {
          await saveCredentials(_email!, _password!);
        } else {
          await clearCredentials();
        }

        SignInResponse response = SignInResponse.fromJson(data);
        if (response.token?.isNotEmpty ?? false) {
          await setToken(response.token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          ); // Navigate to Home
        }
      } catch (e, stackTrace) {
        print(stackTrace);
        hideLoading(); // Hide the loading indicator in case of an error
      }
    }
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = _email != null &&
          _email!.isNotEmpty &&
          _email!.trim().isValidEmail() &&
          _password != null &&
          _password!.isNotEmpty &&
          _password!.trim().length >= 6;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildWithLoading(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                if (!_isKeyboardVisible) ...[
                  const SizedBox(height: 100),
                  Center(
                    child: Image.asset(
                      'assets/images/logoLogin.png',
                      // Đường dẫn đến ảnh của bạn
                      height: 183, // Chiều cao ảnh có thể điều chỉnh
                      width: 183, // Chiều rộng ảnh có thể điều chỉnh
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Khoảng cách giữa ảnh và chữ "Đăng nhập"
                ],
                SizedBox(height: _isKeyboardVisible ? 100 : 10),
                Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      marginH20,
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      marginH8,
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: _emailFocusNode,
                        onChanged: (value) {
                          _email = value;
                          _checkFormValidity();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nhập email của bạn',
                          hintStyle: TextStyle(color: Colors.grey),
                          helperText: '',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorStyle: errorStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email không được để trống.';
                          } else if (!value.trim().isValidEmail()) {
                            return 'Email không hợp lệ.';
                          }
                          return null;
                        },
                      ),
                      marginH8,
                      const Text(
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      marginH8,
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: _passwordFocusNode,
                        obscureText: obscurePassword,
                        obscuringCharacter: '*',
                        onChanged: (value) {
                          _password = value;
                          _checkFormValidity();
                        },
                        decoration: InputDecoration(
                          hintText: 'Nhập mật khẩu của bạn',
                          hintStyle: const TextStyle(color: Colors.grey),
                          helperText: '',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mật khẩu không được để trống.';
                          } else if (value.trim().length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                      marginH4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.translate(
                                offset: const Offset(-8, 0),
                                child: Checkbox(
                                  value: rememberPassword,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (bool? value) async {
                                    await setRememberPassword(value);
                                    setState(() {
                                      rememberPassword = value!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-8, 0),
                                child: const Text(
                                  'Nhớ mật khẩu',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()),
                              );
                            },
                          ),
                        ],
                      ),
                      marginH24,
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () {
                                  _submitForm(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _isFormValid ? Colors.blueAccent : Colors.grey,
                          ),
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      marginH20,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
