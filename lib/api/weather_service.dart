import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey =
      '6467bb2e8d015f23f0b6068f7d23b589'; // Ganti dengan API key Anda

  // Fetch current weather data
  Future<Map<String, dynamic>?> fetchWeatherData(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName,ID&appid=$apiKey&units=metric&lang=id';

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

  // Fetch 5-day forecast data and filter for midday forecasts
  Future<List<Map<String, dynamic>>?> fetchForecastData(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,ID&appid=$apiKey&units=metric&lang=id';

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
                  'temp': item['main']['temp'],
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
}
