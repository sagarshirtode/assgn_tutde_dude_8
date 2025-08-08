import 'dart:convert';

import 'package:assgn_tutde_dude_8/screens/pre_login/login_page.dart';
import 'package:flutter/material.dart';

import '../../services/storage_service.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  String _userType = 'Employer';
  bool _acceptedTerms = false;
  final storage = SecureStorageService();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _currentLocationController =
      TextEditingController();
  final TextEditingController _permanentLocationController =
      TextEditingController();

  String? _idProofPath;

  Future<void> _pickIdProof() async {
    setState(() {
      _idProofPath = 'assets/dummy_id_proof.png';
    });
  }

  void _register() async {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      String? userDataStr = await storage.getDecrypted('userDB');
      if (userDataStr != null) {
        Map<String, dynamic> userData = jsonDecode(userDataStr);
        List<dynamic>? users = userData['users'] as List<dynamic>?;
        if (users != null) {
          for (var user in users) {
            if (user['mobile'] == _mobileController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User already exists')),
              );
              return;
            } else if (user['email'] == _emailController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email already registered')),
              );
              return;
            } else {
              var userType = _userType;
              var mobile = _mobileController.text;
              var email = _emailController.text;
              var name = _nameController.text;
              var idProofPath = _idProofPath ?? 'assets/dummy_id_proof.png';
              var gender = _genderController.text;
              var education = _educationController.text;
              var currentLocation = _currentLocationController.text;
              var permanentLocation = _permanentLocationController.text;

              users.add({
                'userType': userType,
                'mobile': mobile,
                'email': email,
                'name': name,
                'gender': gender,
                'education': education,
                'currentLocation': currentLocation,
                'permanentLocation': permanentLocation,
                'idProofPath': idProofPath
              });
              await storage.setEncrypted('userDB', jsonEncode(userData));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            }
          }
        }
      } else {
        Map<String, dynamic> userData = {
          'users': [
            {
              'userType': _userType,
              'mobile': _mobileController.text,
              'email': _emailController.text,
              'name': _nameController.text,
              'gender': _genderController.text,
              'education': _educationController.text,
              'currentLocation': _currentLocationController.text,
              'permanentLocation': _permanentLocationController.text,
              'idProofPath': _idProofPath
            }
          ]
        };
        await storage.setEncrypted('userDB', jsonEncode(userData));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept terms and conditions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
        backgroundColor: Color(0xFF6dd5ed),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6dd5ed), Color(0xFF2193b0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _userType,
                    items: const [
                      DropdownMenuItem(
                          value: 'Employer', child: Text('Employer')),
                      DropdownMenuItem(
                          value: 'Employeey', child: Text('Employeey')),
                    ],
                    onChanged: (val) => setState(() => _userType = val!),
                    decoration: const InputDecoration(
                      labelText: 'Register As',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => print(_mobileController.text),
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v != null && v.length == 10
                        ? null
                        : 'Enter valid mobile number',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v != null && v.contains('@')
                        ? null
                        : 'Enter valid email',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v != null && v.isNotEmpty ? null : 'Enter full name',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _educationController,
                    decoration: const InputDecoration(
                      labelText: 'Education',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _currentLocationController,
                    decoration: const InputDecoration(
                        labelText: 'Current Location',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _permanentLocationController,
                    decoration: const InputDecoration(
                        labelText: 'Permanent Location',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickIdProof,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload ID Proof'),
                      ),
                      if (_idProofPath != null)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('ID Proof Uploaded',
                              style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: _acceptedTerms,
                    onChanged: (val) =>
                        setState(() => _acceptedTerms = val ?? false),
                    title: const Text('I accept Terms and Conditions'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
