import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class WeatherUi extends StatelessWidget {
  final dynamic response;
  const WeatherUi({super.key,required this.response});

  @override
  Widget build(BuildContext context) {
    String getWeatherCondition(String conditionText) {
    switch (conditionText.toLowerCase()) {
      
      case '1000': //sunny
        return "images/Sunny.json";
      
      case '1003'||'1006'||'1009'||'1030': //cloudy
        return "images/Cloudy.json";
      
      case '1150'||'1153'||'1168'||'1171'||'1180'||     //rain
            '1183'||'1186'||'1189'||'1192'||'1195'||
            '1198'||'1201'||'1204'||'1207'||'1240'||'1243'
            ||'1249'||'1252':
          return "images/Morning light rain.json";
      
      case '1066'||'1069'||'1072'||'1114'||'1117'||
        '1210'||'1213'||'1216'||'1222'||'1237'||'1255'||
        '1258'||'1264': //snow
            return "images/Snow.json";

      case '1087': //thunder
          return "images/thunder.json";

      case '1273'||'1276': //rain+thunder
          return "images/Heavy rain and thunder.json";

      case '1279'||'1282': //cloud+snow 
          return "images/Heavy rain and thunder.json";             
      // Add more cases for other weather conditions if needed
      default:
        return "images/UnknownWeather.json";
    }
  }
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
          AutoSizeText("${response['location']['name']}",
            style:const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700
            ) ,
          ),    
           AutoSizeText("${response['current']['temp_c']}"" \u2103",
            style:const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.w700
            ) ,
          ),
          AutoSizeText("${response['current']['condition']['text']}",
            style:const TextStyle(
              color: Colors.white,
              fontSize: 22,
              // fontWeight: FontWeight.w700
            ) ,
          ),
          Lottie.asset(getWeatherCondition(response['current']['condition']['code'].toString()),width: 200)        
          // Image.network("https:${response['current']['condition']['icon']}",)        

      ], 
  ); 
  }
}