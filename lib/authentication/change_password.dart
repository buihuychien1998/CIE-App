import 'package:flutter/material.dart';
import 'package:home/authentication/enter_otp.dart';
import 'package:home/authentication/login_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String? _newPassword;
  String? _confirmPassword;
  bool _isNewPasswordValid = false;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Đặt lại mật khẩu thành công'),
        ),
      );
      // Navigate back to Login screen after changing password
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Track whether the keyboard is visible
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            // Provide a valid email value for EnterOTP
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EnterOTP(email: 'example@example.com')), // Provide a valid email here
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
                        _isNewPasswordValid = value.length >= 8;
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
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                    obscureText: obscurePassword,
                    obscuringCharacter: '*',
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu';
                      } else if (_isNewPasswordValid && value != _newPassword) {
                        return 'Mật khẩu nhập lại không khớp';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu mới',
                      hintText: 'Nhập lại mật khẩu mới của bạn',
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
    );
  }
}
