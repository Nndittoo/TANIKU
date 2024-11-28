import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
    double temperature, String weather) {
  switch (weather.toLowerCase()) {
    case 'clear':
    case 'sunny':
      if (temperature > 30) {
        return [
          {'name': 'Semangka', 'imagePath': 'assets/images/watermelon.png'},
          {'name': 'Melon', 'imagePath': 'assets/images/melon.png'},
        ];
      } else if (temperature > 20) {
        return [
          {'name': 'Tomat', 'imagePath': 'assets/images/tomato.png'},
          {'name': 'Paprika', 'imagePath': 'assets/images/pepper.png'},
        ];
      } else if (temperature > 10) {
        return [
          {'name': 'Wortel', 'imagePath': 'assets/images/carrot.png'},
          {'name': 'Kentang', 'imagePath': 'assets/images/potato.png'},
        ];
      } else {
        return [
          {'name': 'Kubis', 'imagePath': 'assets/images/cabbage.png'},
          {'name': 'Selada', 'imagePath': 'assets/images/lettuce.png'},
        ];
      }

    case 'rain':
    case 'drizzle':
      return [
        {'name': 'Bayam', 'imagePath': 'asset/img/spinach.jpg'},
        {'name': 'Sawi', 'imagePath': 'asset/img/mustard.png'},
      ];

    case 'clouds':
      return [
        {'name': 'Kubis', 'imagePath': 'assets/images/cabbage.png'},
        {'name': 'Selada', 'imagePath': 'assets/images/lettuce.png'},
      ];

    case 'snow':
      return [
        {'name': 'Kentang', 'imagePath': 'assets/images/potato.png'},
        {'name': 'Wortel', 'imagePath': 'assets/images/carrot.png'},
      ];

    default:
      return [
        {
          'name': 'Tanaman Umum',
          'imagePath': 'assets/images/default_plant.png'
        },
      ];
  }
}
