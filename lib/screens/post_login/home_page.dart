import 'dart:convert';

import 'package:assgn_tutde_dude_8/screens/post_login/darshboard.dart';
import 'package:assgn_tutde_dude_8/screens/post_login/profile_page.dart';
import 'package:assgn_tutde_dude_8/services/storage_service.dart';
import 'package:flutter/material.dart';

import '../pre_login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool IsEmployeer = false;
  final storage = SecureStorageService();
  void checkUserIdLoggedIn() async {
    final storage = SecureStorageService();
    String? LoggedInUser = await storage.getDecrypted('LoggedInUser');
    if (LoggedInUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      Map<String, dynamic> User = jsonDecode(LoggedInUser);
      if (User['userType'] == 'Employer') {
        setState(() {
          IsEmployeer = true;
        });
      } else {
        setState(() {
          IsEmployeer = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserIdLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('PART TIME'),
        centerTitle: false,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: IsEmployeer
          ? const Darshboard()
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    adCard(
                        title: 'Electronic Devices Installation and Repair',
                        city: 'Pune',
                        time: '10:00 AM - 6:00 PM',
                        address: '123 Main St, Pune',
                        phone: '123-456-7890',
                        description:
                            'Looking for someone to install or repair electronic devices? Contact us for quick and reliable service.',
                        posterImageUrl: 'https://picsum.photos/200/300.jpg'),
                    adCard(
                        title: 'Part Time Job 2',
                        city: 'Mumbai',
                        time: '9:00 AM - 5:00 PM',
                        address: '456 Elm St, Mumbai',
                        phone: '987-654-3210',
                        description:
                            'Looking for a part-time job? We have various opportunities available. Contact us for more details.',
                        posterImageUrl: 'https://picsum.photos/200/302.jpg'),
                    adCard(
                        title: 'Part Time Job 3',
                        city: 'Bangalore',
                        time: '11:00 AM - 7:00 PM',
                        address: '789 Oak St, Bangalore',
                        phone: '456-789-0123',
                        description:
                            'Looking for a part-time job? We have various opportunities available. Contact us for more details.',
                        posterImageUrl: 'https://picsum.photos/200/303.jpg'),
                  ],
                ),
              ),
            ),
    );
  }

  Card adCard(
      {required String title,
      required String description,
      required String posterImageUrl,
      required String city,
      required String time,
      required String address,
      required String phone}) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Company Name',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                posterImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Beed'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Interest'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Share'),
                ),
              ],
            ),
            SizedBox(height: 8),
            const Divider(),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'City: $city',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Time: $time',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Address: $address',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Phone: $phone',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
