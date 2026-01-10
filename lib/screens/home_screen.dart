import 'package:flutter/material.dart';
import '../services/weather_service.dart'; // Import Service
import '../models/weather_info.dart'; // Import Model

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // We store the Future so we don't fetch weather on every tiny UI rebuild
  late Future<WeatherInfo> _weatherFuture;

  @override
  void initState() {
    super.initState();
    // Start fetching weather as soon as the screen loads
    _weatherFuture = WeatherService().getCurrentWeather();
  }

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
            // FutureBuilder handles the 3 states: Loading, Error, Success
            FutureBuilder<WeatherInfo>(
              future: _weatherFuture,
              builder: (context, snapshot) {
                // 1. Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Fetching Weather..."),
                    ],
                  );
                }
                // 2. Error State
                else if (snapshot.hasError) {
                  return Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Could not load weather.\n(Check location permissions)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _weatherFuture = WeatherService()
                                .getCurrentWeather();
                          });
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  );
                }
                // 3. Success State
                else if (snapshot.hasData) {
                  final weather = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Get the real icon from OpenWeather's website
                        Image.network(
                          "https://openweathermap.org/img/wn/${weather.iconCode}@2x.png",
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.cloud,
                                size: 80,
                                color: Colors.grey,
                              ),
                        ),
                        Text(
                          "${weather.temperature.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${weather.condition} in ${weather.cityName}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
                return const Text("No Data");
              },
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
