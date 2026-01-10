import 'package:flutter/material.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In the real app, we will pass the DiaryEntry object here.
    // For now, we hardcode the data.

    return Scaffold(
      appBar: AppBar(title: const Text("Oct 20, 2023")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Row(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange),
                  SizedBox(width: 10),
                  Text(
                    "25°C - Sunny",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Diary Title
            const Text(
              "My Great Day",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Diary Content
            const Text(
              "Today was amazing because I finally started my Flutter project. "
              "The weather was perfect for coding outside...",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
