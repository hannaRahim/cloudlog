import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CloudyLog Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Weather Widget
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Icon(Icons.sunny, size: 50, color: Colors.orange),
                  Text(
                    "25°C",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text("Sunny (Placeholder)", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Navigation Buttons
            ElevatedButton.icon(
              icon: const Icon(Icons.book),
              label: const Text("View Diary Entries"),
              onPressed: () => Navigator.pushNamed(context, '/diary_list'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add New Entry"),
              onPressed: () => Navigator.pushNamed(context, '/add_diary'),
            ),
          ],
        ),
      ),
    );
  }
}
