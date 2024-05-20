import 'package:dio/dio.dart';

class WeatherGetApi {
  final Dio dio;
  String apiKey = 'e22f4fd518244105b5643945241605';
  String apiUrl = 'http://api.weatherapi.com/v1/forecast.json';

  WeatherGetApi(this.dio);

  Future<Response> fetchData() async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "key": apiKey,
        "q": "Kottayam",
        "days": "7"
      });
      return response;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
