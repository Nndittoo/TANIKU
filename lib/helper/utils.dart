import 'package:intl/intl.dart';

String getWeatherImage(String input) {
  String assetPath = 'asset/img/';
  switch (input) {
    case 'Thunderstorm':
      return assetPath + 'rain_storm.png';

    case 'Drizzle':
    case 'Rain':
      return assetPath + 'rain.png';

    case 'Clear':
      return assetPath + 'sunny.png';

    case 'Clouds':
      return assetPath + 'cloud.png';

    case 'Mist':
    case 'Fog':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Sand':
    case 'Ash':
      return assetPath + 'fog.png';

    default:
      return assetPath + 'cloud.png';
  }
}

String getDayName(String date) {
  final DateTime dateTime = DateTime.parse(date);
  return DateFormat.EEEE()
      .format(dateTime); // Format nama hari dalam bahasa Indonesia
}
