import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dbproject/loginsignup/login.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final cookieJar = CookieJar();

  void resetPassword() async {
    if (_newPasswordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return;
    }

    try {
      Dio dio = Dio();
      dio.interceptors.add(CookieManager(cookieJar));

      var data = {
        'change-password': 'true',
        'password': _newPasswordController.text.trim(),
        'cpassword': _confirmPasswordController.text.trim(),
      };

      var res = await dio.post(
        'http://172.29.0.1/db_project_database/user/process_reset.php',
        data: FormData.fromMap(data),
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (res.statusCode == 200) {
        var jsonData = res.data;
        if (jsonData['success'] == true) {
          Fluttertoast.showToast(msg: "Password reset successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else {
          Fluttertoast.showToast(msg: jsonData['error']);
        }
      } else {
        Fluttertoast.showToast(msg: 'Unexpected response: ${res.data}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    resetPassword();
                  }
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
