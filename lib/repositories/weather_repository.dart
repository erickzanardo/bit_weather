import 'package:bit_weather/apis/weather_api.dart';
import 'package:bit_weather/models/weather_location.dart';

class WeatherRepository {
  WeatherRepository({
    required this.client,
  });

  final WeatherApi client;

  Future<WeatherLocation?> fetchWeather(String city) async {
    final location = await client.searchLocation(city);

    if (location != null) {
      return client.searchWeather(location.whoid);
    }

    return null;
  }
}
