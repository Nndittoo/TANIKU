// lib/weather_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey =
      '6467bb2e8d015f23f0b6068f7d23b589'; // Ganti dengan API key Anda dari OpenWeatherMap

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

  Future<List<Map<String, dynamic>>?> fetchForecastData(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,ID&appid=$apiKey&units=metric&lang=id';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Kelompokkan data menjadi satu set per hari
        final Map<String, List<Map<String, dynamic>>> dailyData = {};
        for (var entry in data['list']) {
          final date =
              entry['dt_txt'].substring(0, 10); // Ambil hanya tanggalnya
          if (!dailyData.containsKey(date)) {
            dailyData[date] = [];
          }
          dailyData[date]?.add(entry);
        }

        // Ambil data pertama jika jumlah data kurang dari 5
        return dailyData.entries.map((entry) {
          final dayData =
              entry.value.length >= 4 ? entry.value[4] : entry.value[0];
          return {
            'date': entry.key,
            'temp': dayData['main']['temp'],
            'description': dayData['weather'][0]['description'],
          };
        }).toList();
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
