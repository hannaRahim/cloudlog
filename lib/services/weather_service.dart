import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather_info.dart';
import '../utils/constants.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  // 1. Get current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // 2. Fetch Weather using Location
  Future<WeatherInfo> getCurrentWeather() async {
    try {
      Position position = await _determinePosition();

      // We construct the URL dynamically here using the constant we defined
      final url = Uri.parse(
        '$_baseUrl?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$openWeatherApiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return WeatherInfo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching weather: $e");
      // Fallback data so the app doesn't crash during presentation
      return WeatherInfo(
        temperature: 0.0,
        condition: "Unknown",
        description: "Service unavailable",
        iconCode: "01d",
        cityName: "Unknown",
      );
    }
  }
}
