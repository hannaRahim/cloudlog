import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import '../models/diary_entry.dart';

class DiaryDetailScreen extends StatelessWidget {
  final DiaryEntry entry; // Ensure this is stored

  const DiaryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use real date
      appBar: AppBar(title: Text(DateFormat('MMM d, yyyy').format(entry.date))),
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
              child: Row(
                children: [
                  Image.network(
                    "https://openweathermap.org/img/wn/${entry.weather.iconCode}.png",
                    width: 40,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.wb_sunny, color: Colors.orange),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    // Use real weather data
                    "${entry.weather.temperature.toStringAsFixed(1)}°C - ${entry.weather.condition}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Diary Title (Real Data)
            Text(
              entry.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Diary Content (Real Data)
            Text(
              entry.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
