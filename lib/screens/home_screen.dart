import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/weather_service.dart';
import '../models/weather_info.dart';
import '../utils/demo_data.dart';
import '../models/diary_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WeatherInfo> _weatherFuture;
  DiaryEntry? _latestEntry;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().getCurrentWeather();
    _loadLatestEntry();
  }

  void _loadLatestEntry() {
    final entries = DemoData.getEntries();

    if (entries.isNotEmpty) {
      entries.sort((a, b) => b.date.compareTo(a.date));
      setState(() {
        _latestEntry = entries.first;
      });
    } else {
      setState(() {
        _latestEntry = null;
      });
    }
  }

  Future<void> _goToAddDiary() async {
    await Navigator.pushNamed(context, '/add_diary');
    _loadLatestEntry(); // refresh after return
  }

  Future<void> _goToDiaryList() async {
    await Navigator.pushNamed(context, '/diary_list');
    _loadLatestEntry(); // refresh after return
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black54),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section (Greeting + Weather)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Greeting
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi Suhana!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF483D8B),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "How is your day?",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),

                // Weather Card
                FutureBuilder<WeatherInfo>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final w = snapshot.data!;
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F7FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              "https://openweathermap.org/img/wn/${w.iconCode}.png",
                              width: 60,
                              height: 60,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.wb_sunny,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "${w.temperature.toStringAsFixed(0)}°C",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 2. My Diary Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Diary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _goToDiaryList,
                  child: const Text("View All Diaries"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 3. Diary Preview
            if (_latestEntry != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pink.shade50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMM d').format(_latestEntry!.date),
                          style: TextStyle(
                            color: Colors.pink.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.mood, color: Colors.pink.shade300, size: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _latestEntry!.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _latestEntry!.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Center(
                  child: Text("No memories yet. Start writing!"),
                ),
              ),

            const SizedBox(height: 20),

            // 4. Write New Entry Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9370DB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                ),
                onPressed: _goToAddDiary,
                child: const Text(
                  "Write New Entry",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
