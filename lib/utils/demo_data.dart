import '../models/diary_entry.dart';
import '../models/weather_info.dart';

class DemoData {
  // Simple in-memory list to store data while app is running
  static final List<DiaryEntry> _entries = [];

  static List<DiaryEntry> getEntries() {
    return _entries;
  }

  static void addEntry(DiaryEntry entry) {
    _entries.add(entry);
  }
}
