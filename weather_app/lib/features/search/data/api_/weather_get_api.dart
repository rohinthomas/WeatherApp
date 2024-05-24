import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WeatherGetApi {
  final Dio dio;
  String apiKey = 'e22f4fd518244105b5643945241605';
  String apiUrl = 'http://api.weatherapi.com/v1/forecast.json';

  WeatherGetApi(this.dio);

  Future<Map<String,dynamic>> fetchData(value) async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "key": apiKey,
        "q": value,
        "days": "10"
      });
      debugPrint(response.toString());
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

class SearchApi {
  final Dio dio;
  String apiKey = 'e22f4fd518244105b5643945241605';
  String apiUrl = 'http://api.weatherapi.com/v1/search.json?';

  SearchApi(this.dio);

  Future<Map<String,dynamic>> fetchDataSearch(value) async {
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "key": apiKey,
        "q": value,
      });
      
      debugPrint(response.toString());
      
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}