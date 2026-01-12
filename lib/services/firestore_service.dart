import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/diary_entry.dart';
import '../models/weather_info.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Since we have no real Auth, we use a fixed ID for the demo.
  // In a real app, this would come from FirebaseAuth.instance.currentUser.uid
  final String _demoUserId = "demo_student_user_123";

  // 1. Add a new Diary Entry
  Future<void> addEntry(
    String title,
    String content,
    WeatherInfo weather,
  ) async {
    final newEntry = DiaryEntry(
      userId: _demoUserId, // Using the fixed demo ID
      title: title,
      content: content,
      date: DateTime.now(),
      weather: weather,
    );

    // Save to Firestore
    await _db.collection('diary_entries').add(newEntry.toMap());
  }

  // 2. Get entries (Only for our demo user)
  Stream<List<DiaryEntry>> getEntries() {
    return _db
        .collection('diary_entries')
        .where('userId', isEqualTo: _demoUserId) // Only fetch MY demo data
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DiaryEntry.fromFirestore(doc))
              .toList(),
        );
  }
}
