import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherGetApi {
  final Dio dio;
  String apiKey = 'e22f4fd518244105b5643945241605';
  String apiUrl = 'http://api.weatherapi.com/v1/forecast.json';

  WeatherGetApi(this.dio);

  Future<Map<String,dynamic>> fetchData(value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.get(apiUrl, queryParameters: {
        "key": apiKey,
        "q": value,
        "days": "10"
      });
      await prefs.setString('weather_cache', jsonEncode(response.data));
      debugPrint(response.toString());
      return response.data;
    } on DioException catch(e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout){
             final String? data= prefs.getString("weather_cache");
             if(data!=null){
              final dataCache= jsonDecode(data);
             return dataCache;
             }
             else{
              throw Exception("Network isue");
             } 
          }
      throw Exception('Failed to fetch data: $e');
    }
  }
}

class SearchApi {
  final Dio dio;
  String apiKey = 'e22f4fd518244105b5643945241605';
  String apiUrl = 'http://api.weatherapi.com/v1/search.json?';

  SearchApi(this.dio);

  Future<List<dynamic>> fetchDataSearch(value) async {
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