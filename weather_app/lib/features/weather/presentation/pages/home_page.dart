import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
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

class WeatherPageState extends State<WeatherPage> with WidgetsBindingObserver {
  dynamic data;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchDataAndShowModal();
    setUpTimedFetch();
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
      // Get the position asynchronously
      final position = await determinePosition();

      // Convert latitude and longitude to strings
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();

      // Fetch weather data using the obtained latitude and longitude
      Map<String, dynamic> fetchedData =
          await WeatherGetApi(Dio()).fetchData("$latitude,$longitude");

      // Check if the data is valid and the widget is still mounted
      if (fetchedData['location'] != null &&
          fetchedData['location']['name'] != null &&
          mounted) {
        // Update the state with the fetched data
        setState(() {
          data = fetchedData;
        });
      }
    } catch (error) {
      if (mounted) {
        // Handle error only if the widget is still mounted
        print('Error fetching weather data: $error');
      }
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
                    if (data != null) {
                      context.goNamed('search', pathParameters: {
                        'cityname': data['location']['name'].toString(),
                        'conditn': data['current']['condition']['text'].toString(),
                        "deg": data['current']['temp_c'].toString(),
                        "img": data['current']['condition']['icon'].toString()
                      });
                    } else {
                      // Handle case when data is null
                      print("null null!!!!");
                    }
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
      body: data != null
          ? WeatherUi(response: data)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
