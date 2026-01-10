class WeatherInfo {
  final double temperature;
  final String condition; // e.g., "Clear", "Rain"
  final String description; // e.g., "clear sky"
  final String iconCode; // e.g., "01d"
  final String cityName;

  WeatherInfo({
    required this.temperature,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.cityName,
  });

  // Factory constructor to create a WeatherInfo from JSON (API response)
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      cityName: json['name'],
    );
  }

  // Convert to Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'condition': condition,
      'description': description,
      'iconCode': iconCode,
      'cityName': cityName,
    };
  }

  // Factory to create from Firestore Map
  factory WeatherInfo.fromMap(Map<String, dynamic> map) {
    return WeatherInfo(
      temperature: map['temperature'],
      condition: map['condition'],
      description: map['description'],
      iconCode: map['iconCode'],
      cityName: map['cityName'],
    );
  }
}
