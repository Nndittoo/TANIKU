// lib/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:taniku/api/weather_service.dart';
import 'package:intl/intl.dart';
import 'package:taniku/helper/utils.dart';

class CuacaDetail extends StatefulWidget {
  const CuacaDetail({super.key});
  @override
  CuacaDetailPage createState() => CuacaDetailPage();
}

class CuacaDetailPage extends State<CuacaDetail> {
  final String cityName = 'Medan';
  final WeatherService _weatherService = WeatherService();

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final currentData = await _weatherService.fetchWeatherData(cityName);
    return {
      'current': currentData,
    };
  }

  Future<List<Map<String, dynamic>>?> forecastWeather(String cityName) async {
    return await _weatherService.fetchForecastData(cityName);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, dd MMM').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dengan tombol "Location" dan icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Cuaca",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Tindakan ketika tombol location ditekan
                  },
                  icon: const Icon(Icons.location_on),
                  label: Text(cityName),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tanggal yang akan ditampilkan secara dinamis
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  formattedDate, // Menampilkan tanggal yang sudah diformat
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Gambar cuaca di tengah
            FutureBuilder<Map<String, dynamic>>(
              future: fetchWeather(cityName), // Memanggil fetchWeather
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator()); // Tampilkan loading
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error}')); // Tampilkan error jika ada
                } else if (snapshot.hasData) {
                  var currentWeatherData = snapshot.data!['current'];
                  var weatherCondition =
                      currentWeatherData['weather'][0]['main'];
                  String imagePath = getWeatherImage(weatherCondition);

                  return Center(
                    child: Column(
                      children: [
                        Image.asset(
                          imagePath,
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${currentWeatherData['main']['temp']}°C",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentWeatherData['weather'][0]['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 20),
            // Judul Cuaca Minggu Ini
            const Text(
              "Prakiraan Cuaca Harian",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Daftar cuaca
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>?>(
                future: forecastWeather(cityName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Gagal memuat data cuaca'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('Data tidak tersedia'));
                  }

                  final forecasts = snapshot.data!;
                  return ListView.builder(
                    itemCount: forecasts.length,
                    itemBuilder: (context, index) {
                      final forecast = forecasts[index];
                      final isOdd = index % 2 == 1;

                      return Card(
                        color: isOdd ? Colors.grey[200] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Tanggal
                              Text(
                                getDayName(forecast['date']),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    getWeatherImage(forecast['icon']),
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    forecast['weather'], // Deskripsi cuaca
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              // Suhu
                              Text(
                                "${forecast['temp']}°C",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
