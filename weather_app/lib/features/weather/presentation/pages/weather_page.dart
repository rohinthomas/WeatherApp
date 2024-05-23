import 'package:flutter/material.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
import 'package:weather_app/features/search/presentation/pages/search_page.dart';
import 'package:weather_app/features/weather/domain/location.dart';
import 'package:weather_app/features/weather/presentation/widget/weather_ui.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/logout.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    fetchDataAndShowModal();
  }

void fetchDataAndShowModal() async {
  try {
    // Get the position asynchronously
    final position = await determinePosition();
    
    // Convert latitude and longitude to strings
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    
    // Fetch weather data using the obtained latitude and longitude
    Map<String, dynamic> data = await WeatherGetApi(Dio()).fetchData("$latitude,$longitude");
    
    // Check if the data is valid and the widget is still mounted
    if (data['location'] != null && data['location']['name'] != null && context.mounted) {
      // Update the state with the fetched data
      setState(() {
        this.data = data;
      });
    }
  } catch (error) {
    // Handle error
    print('Error fetching weather data: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double mainTextWidth = screenWidth * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchPage()),
                    );
                  },
                  child: const Icon(Icons.search_outlined, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: mainTextWidth,
              child: const Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "Weather App",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  maxLines: 1,
                ),
              ),
            ),
            const Expanded(
              child: Logout(),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: data != null ? WeatherUi(response: data) : const Center(child: CircularProgressIndicator()),
    );
  }
}
