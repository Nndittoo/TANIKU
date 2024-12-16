import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey =
      '6467bb2e8d015f23f0b6068f7d23b589'; // Ganti dengan API key Anda

  // Fetch current weather data using lat/lon
  Future<Map<String, dynamic>?> fetchWeatherDataByLocation(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=id';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  // Fetch 5-day forecast data using lat/lon and filter for midday forecasts
  Future<List<Map<String, dynamic>>?> fetchForecastDataByLocation(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=id';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> list = data['list'];

        // Filter only forecasts with time "12:00:00"
        final List<Map<String, dynamic>> middayForecasts = list
            .where((item) => item['dt_txt'].endsWith('12:00:00'))
            .map((item) => {
                  'date': item['dt_txt'],
                  'temp': item['main']['temp'].toInt(),
                  'weather': item['weather'][0]['description'],
                  'icon': item['weather'][0]['main'],
                })
            .toList();

        return middayForecasts;
      } else {
        log('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  // Get current position using Geolocator
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. Cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition();
  }
}
