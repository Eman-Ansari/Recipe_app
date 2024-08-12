import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'password_reset.dart'; // Import your PasswordResetScreen

class VerifyOtpScreen extends StatefulWidget {
  final String email; // This will be passed from the previous screen

  VerifyOtpScreen({required this.email}); // Constructor to receive email

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  void verifyOtp() async {
    try {
      var otp = _otpController.text.trim();
      var email = widget.email; // Use email from the widget

      print('Sending OTP: $otp');
      print('Sending Email: $email');

      var res = await http.post(
        Uri.parse('http://172.29.0.1/db_project_database/user/verifyotp.php'),
        body: {
          'email': email,
          'otp': otp,
        },
      );

      print('HTTP Status Code: ${res.statusCode}');
      print('Raw Response: ${res.body}'); // Log the raw response

      if (res.statusCode == 200) {
        try {
          var jsonData = jsonDecode(res.body);
          if (jsonData['success'] == true) {
            Fluttertoast.showToast(msg: "OTP verified successfully");
            // Navigate to password reset screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordResetScreen()),
            );
          } else {
            Fluttertoast.showToast(msg: jsonData['error']);
          }
        } catch (e) {
          Fluttertoast.showToast(msg: 'JSON decode error: $e');
          print('JSON decode error: $e');
        }
      } else {
        Fluttertoast.showToast(msg: 'Unexpected response: ${res.body}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'OTP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    verifyOtp();
                  }
                },
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
