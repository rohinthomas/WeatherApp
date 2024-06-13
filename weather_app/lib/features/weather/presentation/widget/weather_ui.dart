import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widget/future_weather_card.dart';
import 'package:weather_app/features/weather/presentation/widget/hour_card.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherUi extends StatelessWidget {
  final dynamic response;
  const WeatherUi({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weatherList = List<Map<String, dynamic>>.from(
        response['forecast']['forecastday'][0]['hour']);
    List<Map<String, dynamic>> forecastList =
        List<Map<String, dynamic>>.from(response['forecast']['forecastday']);

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double timeLogoSize = screenWidth * 0.04;
    final String city="${response['location']['name']}";
    // Helper function to get weather condition image path
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
        case '1063':
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
          return "images/logo.png";
      }
    }

    String getUvInfo(var conditionUv) {
      switch (conditionUv) {
        case 0:
        case 1:
        case 2:
          return ("Low");
        case 3:
        case 4:
        case 5:
          return ("Moderate");
        case 6:
        case 7:
          return ("High");
        case 8:
        case 9:
        case 10:
          return ("Very High");
        default:
          return ("Extreme");
      }
    }

    String calculateVisibility(String visibility) {
      double vis = double.parse(visibility);
      switch (vis) {
        case > 10:
          return "Clear";
        case > 5:
          return "Good";
        case > 1:
          return "Moderate";
        case < 1:
          return "Very Poor";
        default:
          return "";
      }
    }

    String calculateDewPoint(var temperature, var humidity) {
      // Constants for the formula

      double temp = double.parse(temperature);
      double hum = double.parse(humidity);
      const double a = 17.27;
      const double b = 237.7;

      // Calculate the alpha value
      double alpha = ((a * temp) / (b + temp)) + log(hum / 100);

      // Calculate the dew point
      double dewPoint = (b * alpha) / (a - alpha);

      return dewPoint.toStringAsFixed(2);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          city,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        AutoSizeText(
          " ${response['current']['temp_c'] ?? 'N/A'}\u00B0",
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontSize: 43, fontWeight: FontWeight.w700),
        ),
        AutoSizeText(
          response['current']['condition']['text'] ?? 'Unknown Condition',
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8,),
          child: SizedBox(
            height: screenHeight * 0.67,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: [
                  Image.asset(
                    getWeatherCondition(
                        response['current']['condition']['code'].toString()),
                    height: screenWidth * 0.45,
                  ),
                  Card(
                    color: const Color.fromARGB(255, 33, 33, 33),


                    child: SizedBox(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time_outlined,
                                    color: Colors.white, size: timeLogoSize),
                                const AutoSizeText(
                                  "  HOURLY FORECAST",
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  minFontSize: 5,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weatherList.length,
                                itemBuilder: (context, index) {
                                  return Hourcard(
                                      response: weatherList[index]);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 3 day weather forecast
                  Card(
                    color: const Color.fromARGB(255, 33, 33, 33),

                    child: SizedBox(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.date_range,
                                    color: Colors.white, size: timeLogoSize),
                                const AutoSizeText(
                                  "  10-DAY FORECAST",
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  minFontSize: 5,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: forecastList.map((weather) {
                                  return FutureWeatherCard(response: weather);
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    child: Row(
                      
                      children: [
                        Card(
                          color: const Color.fromARGB(255, 33, 33, 33),

                          child: SizedBox(
                            width: screenWidth * 0.3133,
                            height: screenHeight * 0.165,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sunny,
                                          color: Colors.white,
                                          size: timeLogoSize),
                                      const AutoSizeText(
                                        "  UV INDEX",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        minFontSize: 5,
                                      )
                                    ],
                                  ),
                                ),
                                AutoSizeText(
                                  "${response['forecast']['forecastday'][0]['day']['uv']}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  minFontSize: 5,
                                ),
                                AutoSizeText(
                                    getUvInfo(response['forecast']
                                        ['forecastday'][0]['day']['uv']),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        //himidity
                        Card(
                          color: const Color.fromARGB(255, 33, 33, 33),

                          child: SizedBox(
                            width: screenWidth * 0.3133,
                            height: screenHeight * 0.165,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(WeatherIcons.humidity,
                                          color: Colors.white,
                                          size: screenWidth * 0.034),
                                      const AutoSizeText(
                                        "  HUMIDITY",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        minFontSize: 5,
                                      )
                                    ],
                                  ),
                                ),
                                AutoSizeText(
                                  maxLines: 1,
                                  "${response['current']['humidity']}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  minFontSize: 5,
                                ),
                                AutoSizeText(
                                    maxLines: 1,
                                    "Dew Point ${calculateDewPoint(response['current']['temp_c'].toString(), response['current']['humidity'].toString())}\u00B0",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        //feels like
                        Card(
                          color: const Color.fromARGB(255, 33, 33, 33),

                          child: SizedBox(
                            width: screenWidth * 0.3094,
                            height: screenHeight * 0.165,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(WeatherIcons.thermometer_exterior,
                                          color: Colors.white,
                                          size: screenWidth * 0.034),
                                      const AutoSizeText(
                                        maxLines: 1,
                                        "FEELS LIKE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        minFontSize: 5,
                                      )
                                    ],
                                  ),
                                ),
                                AutoSizeText(
                                  maxLines: 1,
                                  "${response['current']['feelslike_c']}\u00B0",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  minFontSize: 5,
                                ),
                                const AutoSizeText("Apparerent temp",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(255, 33, 33, 33),

                    child: SizedBox(
                      width: screenWidth * 0133,
                      height: screenHeight * 0.14,
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              
                              children: [
                                Icon(WeatherIcons.windy,
                                    color: Colors.white,
                                    size: screenWidth * 0.034),
                                const AutoSizeText(
                                  maxLines: 1,
                                  "  WIND",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  minFontSize: 5,
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // height: MediaQuery.of(context).size.height ,
                                  width: MediaQuery.of(context).size.width *0.24,
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        "  ${response['current']['wind_kph']}",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                        ),
                                        minFontSize: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Column(
                                      children: [
                                        AutoSizeText(
                                          "KPH",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                        AutoSizeText(
                                          "Wind",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *0.24,
                          
                                  child: AutoSizeText(
                                    "  ${response['current']['gust_kph']}",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                    ),
                                    minFontSize: 5,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Column(
                                      children: [
                                        AutoSizeText(
                                          "KPH",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                        AutoSizeText(
                                          "Gusts",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *0.24,
                          
                                  child: AutoSizeText(
                                    "  ${response['current']['wind_degree']}\u00B0",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                    ),
                                    minFontSize: 5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      
                                      children: [
                                        const AutoSizeText(
                                          "",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                        AutoSizeText(
                                          "${response['current']['wind_dir']}",
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          minFontSize: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 33, 33, 33),

                        child: SizedBox(
                          width: screenWidth * 0.48,
                          height: screenHeight * 0.16,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(WeatherIcons.raindrop,
                                        color: Colors.white,
                                        size: timeLogoSize),
                                    const AutoSizeText(
                                      maxLines: 1,
                                      "  RAIN FALL",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      minFontSize: 5,
                                    )
                                  ],
                                ),
                              ),
                              AutoSizeText(
                                maxLines: 1,
                                "${response['current']['precip_mm']} mm",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                minFontSize: 5,
                              ),
                              const AutoSizeText("in last 24hr",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      //himidity
                      Card(
                        color: const Color.fromARGB(255, 33, 33, 33),

                        child: SizedBox(
                          width: screenWidth * 0.475,
                          height: screenHeight * 0.16,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.remove_red_eye,
                                        color: Colors.white,
                                        size: screenWidth * 0.034),
                                    const AutoSizeText(
                                      maxLines: 1,
                                      "  VISIBILITY",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      minFontSize: 5,
                                    )
                                  ],
                                ),
                              ),
                              AutoSizeText(
                                maxLines: 1,
                                "${response['current']['vis_km']} km",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                minFontSize: 5,
                              ),
                              AutoSizeText(
                                  calculateVisibility(response['current']
                                          ['vis_km']
                                      .toString()),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                                        ],
                                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
