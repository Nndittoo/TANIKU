import 'package:intl/intl.dart';

String getWeatherImage(String input) {
  String assetPath = 'asset/img/';
  switch (input) {
    case 'Thunderstorm':
      return '${assetPath}rain_storm.png';

    case 'Drizzle':
    case 'Rain':
      return '${assetPath}rain.png';

    case 'Clear':
      return '${assetPath}sunny.png';

    case 'Clouds':
      return '${assetPath}cloud.png';

    case 'Mist':
    case 'Fog':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Sand':
    case 'Ash':
      return '${assetPath}fog.png';

    default:
      return '${assetPath}cloud.png';
  }
}

String getDayName(String date) {
  final DateTime dateTime = DateTime.parse(date);
  return DateFormat.EEEE()
      .format(dateTime); // Format nama hari dalam bahasa Indonesia
}

List<Map<String, String>> getPlantRecommendations(
    double temperature, String weather, int humidity, double rainfall) {
  // List untuk menyimpan rekomendasi tanaman
  List<Map<String, String>> plantRecommendations = [];

  // Fungsi untuk menambahkan item tanpa duplikat
  void addRecommendation(Map<String, String> plant) {
    // Cek apakah item sudah ada berdasarkan nama
    if (!plantRecommendations
        .any((existingPlant) => existingPlant['name'] == plant['name'])) {
      plantRecommendations.add(plant);
    }
  }

  // Menggunakan kondisi cuaca
  switch (weather.toLowerCase()) {
    case 'clear':
    case 'sunny':
      if (temperature > 30) {
        addRecommendation(
            {'name': 'Semangka', 'imagePath': 'asset/img/semangka.png'});
        addRecommendation(
            {'name': 'Melon', 'imagePath': 'asset/img/melon.png'});
      } else if (temperature > 20) {
        addRecommendation(
            {'name': 'Tomat', 'imagePath': 'asset/img/tomat.png'});
      } else if (temperature > 10) {
        addRecommendation(
            {'name': 'Wortel', 'imagePath': 'asset/img/wortel.png'});
        addRecommendation(
            {'name': 'Kentang', 'imagePath': 'asset/img/kentang.png'});
      } else {
        addRecommendation(
            {'name': 'Kubis', 'imagePath': 'asset/img/kubis.png'});
        addRecommendation(
            {'name': 'Selada', 'imagePath': 'asset/img/selada.png'});
      }
      break;

    case 'rain':
    case 'drizzle':
      addRecommendation({'name': 'Bayam', 'imagePath': 'asset/img/bayam.png'});
      addRecommendation({'name': 'Sawi', 'imagePath': 'asset/img/sawi.png'});
      break;

    case 'clouds':
      addRecommendation({'name': 'Kubis', 'imagePath': 'asset/img/kubis.png'});
      addRecommendation(
          {'name': 'Selada', 'imagePath': 'asset/img/selada.png'});
      break;

    default:
      addRecommendation(
          {'name': 'Tidak ada', 'imagePath': 'asset/img/tidakada.png'});
  }

  // Logika berdasarkan kelembapan
  if (humidity > 40 && humidity <= 70) {
    addRecommendation({'name': 'Cabai', 'imagePath': 'asset/img/cabai.png'});
    addRecommendation({'name': 'Tomat', 'imagePath': 'asset/img/tomat.png'});
  } else {
    addRecommendation({'name': 'Mangga', 'imagePath': 'asset/img/mangga.png'});
    addRecommendation({'name': 'Jeruk', 'imagePath': 'asset/img/jeruk.png'});
  }

  // Logika berdasarkan curah hujan
  if (rainfall > 1.0) {
    addRecommendation({'name': 'Cabai', 'imagePath': 'asset/img/cabai.png'});
    addRecommendation({'name': 'Tomat', 'imagePath': 'asset/img/tomat.png'});
  } else if (rainfall > 0.5 && rainfall <= 1.0) {
    addRecommendation({'name': 'Cabai', 'imagePath': 'asset/img/cabai.png'});
    addRecommendation({'name': 'Tomat', 'imagePath': 'asset/img/tomat.png'});
  } else {
    addRecommendation({'name': 'Mangga', 'imagePath': 'asset/img/mangga.png'});
    addRecommendation({'name': 'Jeruk', 'imagePath': 'asset/img/jeruk.png'});
  }

  return plantRecommendations;
}
