import 'package:cloud_firestore/cloud_firestore.dart';
import 'weather_info.dart';

class DiaryEntry {
  final String? id; // Firestore Document ID
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final WeatherInfo weather;

  DiaryEntry({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    required this.weather,
  });

  // Convert to Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'date': Timestamp.fromDate(date), // Firestore uses Timestamp
      'weather': weather.toMap(), // Nested Map
    };
  }

  // Factory to create from Firestore Document
  factory DiaryEntry.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DiaryEntry(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      weather: WeatherInfo.fromMap(data['weather']),
    );
  }
}
