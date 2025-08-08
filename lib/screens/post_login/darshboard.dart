import 'package:flutter/material.dart';

class Darshboard extends StatefulWidget {
  const Darshboard({super.key});

  @override
  State<Darshboard> createState() => _DarshboardState();
}

class _DarshboardState extends State<Darshboard> {
  Widget gapH20 = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              'Welcome to the Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            gapH20,
            const Text(
              'Here you can manage your ads and profile',
              style: TextStyle(fontSize: 16),
            ),
            gapH20,
            const Text(
              'Current Ads:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            gapH20,
            const Text(
              'No ads available at the moment.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            gapH20,
            const Text(
              'No current ads to display.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            gapH20,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Create New Ad'),
            ),
            gapH20,
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Profile'),
            ),
            gapH20,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Logout'),
            ),
            gapH20,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Settings'),
            ),
            gapH20,
            const Text(
              'Additional Features Coming Soon!',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            gapH20,
            const Text(
              'Footer Content Here',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            gapH20,
            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            gapH20,
            const Text(
              'Additional Content Here',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
