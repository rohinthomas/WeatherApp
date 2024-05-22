import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widget/hour_card.dart';

class WeatherUi extends StatelessWidget {
  final dynamic response;
  const WeatherUi({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weatherList = List<Map<String, dynamic>>.from(response['forecast']['forecastday'][0]['hour']);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double timeLogoSize= screenWidth *0.04;
    String getWeatherCondition(String conditionCode) {
      switch (conditionCode) {
        case '1000': // sunny
          return "images/sunny.png";
        case '1003':
        case '1006':
        case '1009':
        case '1030': // cloudy
          return "images/cloudy.png";
        case '1150':
        case '1153':
        case '1168':
        case '1171':
        case '1180':
        case '1183':
        case '1186':
        case '1189':
        case '1192':
        case '1195':
        case '1198':
        case '1201':
        case '1204':
        case '1207':
        case '1240':
        case '1243':
        case '1249':
        case '1252': // rain
          return "images/rain.png";
        case '1066':
        case '1069':
        case '1072':
        case '1114':
        case '1117':
        case '1210':
        case '1213':
        case '1216':
        case '1222':
        case '1237':
        case '1255':
        case '1258':
        case '1264': // snow
          return "images/snow.png";
        case '1087': // thunder
          return "images/thunder.png";
        case '1273':
        case '1276': // rain+thunder
          return "images/rainThunder.png";
        case '1279':
        case '1282': // cloud+snow
          return "images/heavy_rain_and_thunder.png";
        // Add more cases for other weather conditions if needed
        default:
          return "images/unknown_weather.png";
      }
    }
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          "${response['location']['name']}",
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        AutoSizeText(
          " ${response['current']['temp_c']}\u00B0",
          style: const TextStyle(
              color: Colors.white, fontSize: 60, fontWeight: FontWeight.w700),
        ),
        AutoSizeText(
          "${response['current']['condition']['text']}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            // fontWeight: FontWeight.w700
          ),
        ),
        Image.asset(
          getWeatherCondition(response['current']['condition']['code'].toString()),
          width: screenWidth * 0.7,
        ),
        Card(
          color: const Color.fromARGB(53, 32, 32, 32),
          child: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.15,
            child: Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                          Icon(Icons.access_time_outlined,color: Colors.white,size:timeLogoSize),
                          const AutoSizeText("  HOURLY FORECAST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15, 
                                  fontWeight: FontWeight.bold
                                ),
                                minFontSize: 5,
                            )
                          ],
                        ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherList.length,
                    itemBuilder: (context, index){
                        return Hourcard(
                          response:weatherList[index]
                        );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
