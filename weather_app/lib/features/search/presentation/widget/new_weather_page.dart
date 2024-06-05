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

class NWeatherPageState extends State<NewWeatherPage> with WidgetsBindingObserver {
  dynamic data;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDataAndShowModal();
      setUpTimedFetch();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      setUpTimedFetch();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
      _timer?.cancel();
    }
  }

  void setUpTimedFetch() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchDataAndShowModal();
    });
  }

  Future<void> fetchDataAndShowModal() async {
    try {
      // Fetch weather data for the given location
      Map<String, dynamic> fetchedData = await WeatherGetApi(Dio()).fetchData(widget.location);
      // If valid data is returned, update the state
      if (fetchedData['location'] != null && fetchedData['location']['name'] != null && mounted) {
        setState(() {
          data = fetchedData;
        });
      }
    } catch (error) {
      if (mounted) {
        print('Error fetching weather data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255), // Change this to your desired color
        ),
        title: const Row(
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
