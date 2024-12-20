import 'package:flutter/material.dart';
import 'package:home/authentication/enter_otp.dart';
import 'package:home/authentication/login_screen.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with WidgetsBindingObserver {
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

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Gửi yêu cầu khôi phục mật khẩu thành công'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnterOTP(email: _email!), // Truyền email vào đây
        ),
      );
    }
  }

  bool get _isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      validator: (value) {
                        final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@stu\.ptit\.edu\.vn$');
                        if (value != null && !emailPattern.hasMatch(value)) {
                          return 'Email phải bao gồm "@stu.ptit.edu.vn"';
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
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _email != null && _email!.contains('@stu.ptit.edu.vn')
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
    );
  }
}
