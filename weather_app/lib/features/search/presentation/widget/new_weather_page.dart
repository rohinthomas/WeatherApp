import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
import 'package:weather_app/features/weather/presentation/widget/weather_ui.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/logout.dart';

class NewWeatherPage extends StatefulWidget {
  final String location;
  const NewWeatherPage({super.key, required this.location});

  @override
  NWeatherPageState createState() => NWeatherPageState();
}

class NWeatherPageState extends State<NewWeatherPage> {
  dynamic data;
  Timer? _timer;

  @override
 void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Your initialization code here
    fetchDataAndShowModal();
    setUpTimedFetch();
  });
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setUpTimedFetch() {
    // Set up a periodic timer to fetch data every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchDataAndShowModal();
    });
  }

  Future<void> fetchDataAndShowModal() async {
    try {
      // Fetch weather data for the given location
      Map<String, dynamic> data = await WeatherGetApi(Dio()).fetchData(widget.location);
      // If valid data is returned, update the state
      if (data['location'] != null && data['location']['name'] != null && mounted) {
        setState(() {
          this.data = data;
        });
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color:  Color.fromARGB(255, 255, 255, 255), // Change this to your desired color
        ),
        title:const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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