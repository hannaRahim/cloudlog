import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_info.dart';
import '../models/diary_entry.dart';
import '../utils/demo_data.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  WeatherInfo? _currentWeather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weather = await WeatherService().getCurrentWeather();
    if (mounted) {
      setState(() {
        _currentWeather = weather;
        _isLoading = false;
      });
    }
  }

  void _saveEntry() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (_currentWeather == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fetching weather info...")));
      return;
    }

    final newEntry = DiaryEntry(
      userId: 'demo_user',
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
      weather: _currentWeather!,
    );

    // Save to local DemoData
    DemoData.addEntry(newEntry);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Write Entry",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weather Widget
                  if (!_isLoading && _currentWeather != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            "https://openweathermap.org/img/wn/${_currentWeather!.iconCode}.png",
                            width: 30,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.cloud, size: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${_currentWeather!.temperature.toStringAsFixed(1)}°C - ${_currentWeather!.condition}",
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Title Input
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Title...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                  ),

                  const Divider(thickness: 1, height: 30),

                  // Content Input
                  TextField(
                    controller: _contentController,
                    maxLines: null, // Grows automatically
                    style: const TextStyle(fontSize: 18, height: 1.6),
                    decoration: const InputDecoration(
                      hintText: "What's on your mind today?",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9370DB), // Medium Purple
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Save Entry",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
