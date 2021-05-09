import 'package:bit_weather/env.dart';
import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:dio/dio.dart';

class WeatherApi {
  WeatherApi({required this.dio});

  final Dio dio;

  Future<Location?> searchLocation(String query) async {
    final response = await dio.get('${BitWeatherEnv.apiHost}location/search',
        queryParameters: {'query': query});

    final jsonResponse = response.data as List<dynamic>;
    if (jsonResponse.isNotEmpty) return Location.fromJson(jsonResponse.first);

    return null;
  }

  Future<WeatherLocation?> searchWeather(int whoid) async {
    try {
      final response = await dio.get(
        '${BitWeatherEnv.apiHost}location/$whoid',
      );

      final jsonResponse = response.data as Map<String, dynamic>;

      final location = Location.fromJson(jsonResponse);

      final consolidatedWeatherArray =
          jsonResponse['consolidated_weather'] as List<dynamic>;

      final weather = Weather.fromJson(consolidatedWeatherArray.first);

      return WeatherLocation(
        location: location,
        weather: weather,
        updatedAt: DateTime.now(),
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      rethrow;
    }
  }
}
