import 'dart:convert';
import 'package:dbproject/loginsignup/VerifyOtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void sendPasswordResetEmail() async {
    try {
      var email = _emailController.text.trim();
      var res = await http.post(
        Uri.parse(
            'http://172.29.0.1/db_project_database/user/forgot_password.php'),
        body: {
          'email': email,
        },
      );

      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        if (jsonData['success'] == true) {
          Fluttertoast.showToast(msg: "Password reset email sent");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifyOtpScreen(email: email), // Pass the email here
            ),
          );
        } else {
          Fluttertoast.showToast(msg: jsonData['error']);
        }
      } else {
        Fluttertoast.showToast(msg: 'Unexpected response: ${res.body}');
        // Handle unexpected HTML response or other errors
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendPasswordResetEmail();
                  }
                },
                child: Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
