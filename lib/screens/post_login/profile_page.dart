import 'dart:convert';

import 'package:assgn_tutde_dude_8/screens/post_login/home_page.dart';
import 'package:assgn_tutde_dude_8/screens/pre_login/login_page.dart';
import 'package:assgn_tutde_dude_8/services/storage_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = SecureStorageService();
  Widget gapH20 = const SizedBox(height: 20);
  String? name;
  String? email;
  void getUserdata() async {
    String? LoggedInUser = await storage.getDecrypted('LoggedInUser');
    if (LoggedInUser != null) {
      Map<String, dynamic> user = jsonDecode(LoggedInUser);
      String name = user['name'] ?? 'User Name';
      String email = user['email'] ?? 'NA';
      setState(() {
        this.name = name;
        this.email = email;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRXeRMGof2srf44GSCMKhzxcu4xIHpVf_0YDZ6YFDYIVxO7zmi7-2RKC4XbYEA16H70NEQU52HU2coFGw61HdvxWA', // Placeholder image URL
              ),
            ),
            gapH20,
            Text(
              name ?? 'User Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            gapH20,
            Text(email ?? 'NA'),
            gapH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  index < (5) ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            gapH20,
            const Text('Completed Assignments: 5', style: TextStyle(fontSize: 16)),
            gapH20,
            const Text('Ongoing Assignments: 2', style: TextStyle(fontSize: 16)),
            gapH20,
            const Text('Pending Assignments: 1', style: TextStyle(fontSize: 16)),
            gapH20,
            ElevatedButton(
              onPressed: () async {
                await storage.delete('LoggedInUser');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
