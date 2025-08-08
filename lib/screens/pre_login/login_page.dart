import 'dart:convert';

import 'package:assgn_tutde_dude_8/screens/post_login/home_page.dart';
import 'package:assgn_tutde_dude_8/screens/pre_login/register_user.dart';
import 'package:assgn_tutde_dude_8/services/storage_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final storage = SecureStorageService();

  bool _otpSent = false;

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      var userData = await storage.getDecrypted('userDB');
      if (userData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user data found')),
        );
        return;
      } else {
        String? userDataStr = await storage.getDecrypted('userDB');
        if (userDataStr != null) {
          Map<String, dynamic> userData = jsonDecode(userDataStr);
          if (userData['users'][0]['mobile'] == _mobileController.text) {
            storage.setEncrypted(
              'LoggedInUser',
              jsonEncode(userData['users'][0]),
            );
            setState(() {
              _otpSent = true;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mobile number not found')),
            );
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to ${_mobileController.text}')),
      );
    }
  }

  void _login() async {
    if (_otpController.text.length == 6) {
      String? userDataStr = await storage.getDecrypted('userDB');
      if (userDataStr != null) {
        Map<String, dynamic> userData = jsonDecode(userDataStr);
        List<dynamic>? users = userData['users'] as List<dynamic>?;
        if (users != null) {
          for (var user in users) {
            if (user['mobile'] == _mobileController.text) {
              await storage.setEncrypted('USER', jsonEncode(user));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              return;
            }
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  void _unlockAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account unlock link sent!')),
    );
  }

  void _registerUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterUser()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.phone_android,
                      ),
                      hintText: 'Enter your 10-digit mobile number',
                    ),
                    validator: (value) {
                      if (value == null || value.length != 10) {
                        return 'Enter valid 10-digit mobile number';
                      }
                      return null;
                    },
                    enabled: !_otpSent,
                  ),
                ),
                const SizedBox(height: 16),
                if (_otpSent)
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'OTP',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 6,
                    ),
                  ),
                const SizedBox(height: 16),
                !_otpSent
                    ? ElevatedButton(
                        onPressed: _sendOtp,
                        child: const Text('Send OTP'),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _unlockAccount,
                  child: const Text('Unlock Account'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _registerUser,
                  child: const Text('Register User'),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Note: Register only one user is allowed to login to test Employee and Employer functionality. Clear local storage to register new user.',
                        style: TextStyle(color: Colors.yellow),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tested on: ON WEB',
                        style: TextStyle(color: Colors.red),
                      ),
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
