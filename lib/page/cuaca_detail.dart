// lib/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:taniku/api/weather_service.dart';

class CuacaDetail extends StatefulWidget {
  const CuacaDetail({super.key});
  @override
  CuacaDetailPage createState() => CuacaDetailPage();
}

class CuacaDetailPage extends State<CuacaDetail> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? currentWeatherData;
  List<Map<String, dynamic>>? forecastData;
  String cityName = 'Medan'; // Kota default di Indonesia

  final List<String> cities = [
    'Medan',
    'Pematangsiantar',
    'Binjai',
    'Saribudolok',
    'Parapat',
    'Kabanjahe',
  ];

  // Map kondisi cuaca dengan file gambar
  final Map<String, String> weatherImages = {
    'clear sky': 'asset/img/clearsky.png',
    'few clouds': 'asset/img/fewclouds.png',
    'scattered clouds': 'asset/img/cloud.png',
    'broken clouds': 'asset/img/fewclouds.png',
    'shower rain': 'asset/img/lightrain.png',
    'rain': 'asset/img/lightrain.png',
    'light rain': 'asset/img/lightrain.png',
    'thunderstorm': 'asset/img/storm.png',
    'snow': 'asset/img/snow.png',
    'mist': 'asset/img/mist.png',
    // Tambahkan kondisi cuaca lain sesuai kebutuhan
  };

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final currentData = await _weatherService.fetchWeatherData(cityName);
    final forecast = await _weatherService.fetchForecastData(cityName);
    setState(() {
      currentWeatherData = currentData;
      forecastData = forecast;
    });
  }

  void _onCityChanged(String? selectedCity) {
    if (selectedCity != null) {
      setState(() {
        cityName = selectedCity;
      });
      fetchWeather();
    }
  }

  Widget _buildWeatherImage() {
    if (currentWeatherData != null) {
      String weatherCondition =
          currentWeatherData!['weather'][0]['description'];

      // Cari gambar sesuai kondisi cuaca atau gunakan gambar default
      String imagePath =
          weatherImages[weatherCondition] ?? 'asset/img/cloud.png';
      return Image.asset(imagePath);
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prakiraan Cuaca - $cityName'),
      ),
      body: currentWeatherData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Pilih Kota: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: cityName,
                          items: cities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: _onCityChanged,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildWeatherImage(), // Menampilkan gambar sesuai kondisi cuaca
                    const SizedBox(height: 16),
                    Text(
                      'Suhu Saat Ini: ${currentWeatherData!['main']['temp']}°C',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cuaca: ${currentWeatherData!['weather'][0]['description']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kelembapan: ${currentWeatherData!['main']['humidity']}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Prakiraan Cuaca Harian:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    forecastData == null
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: forecastData!.map((day) {
                              return Card(
                                child: ListTile(
                                  title: Text(day['date']),
                                  subtitle: Text(day['description']),
                                  trailing: Text('${day['temp']}°C'),
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
