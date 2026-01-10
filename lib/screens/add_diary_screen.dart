import 'package:flutter/material.dart';

class AddDiaryScreen extends StatelessWidget {
  const AddDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Write Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Shows user the weather that will be attached
            const Row(
              children: [
                Icon(Icons.wb_sunny, size: 20),
                SizedBox(width: 8),
                Text("Weather: 25°C Sunny (Auto-detected)"),
              ],
            ),
            const Divider(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "Dear Diary...",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save to Firestore
                  Navigator.pop(context);
                },
                child: const Text("Save Entry"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
