import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15, // Convert from Kelvin to Celsius
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
class WeatherService {
  static const String apiKey = "f112deedd42070693e96b6b19f15b746";
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel?> getWeatherData(String cityName) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return WeatherModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}