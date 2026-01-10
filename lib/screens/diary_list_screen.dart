import 'package:flutter/material.dart';
import 'diary_detail_screen.dart'; // <--- THIS WAS THE MISSING IMPORT

class DiaryListScreen extends StatelessWidget {
  const DiaryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Diary")),
      body: ListView.builder(
        itemCount: 5, // Fake data count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.cloud_queue),
              title: Text("Diary Entry #$index"),
              subtitle: const Text("This is a placeholder..."),
              onTap: () {
                // Navigate to the detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiaryDetailScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add_diary'),
      ),
    );
  }
}
