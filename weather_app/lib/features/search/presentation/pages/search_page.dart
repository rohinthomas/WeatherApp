import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
import 'package:weather_app/features/search/presentation/widget/show_weather_modal.dart';
import 'package:weather_app/logout.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  String? searchValue;
  dynamic searchSuggestions = [];

  @override
  Widget build(BuildContext context) {
    bool flg = true;
    var screenHeight = MediaQuery.of(context).size.height;
    double searchPaddingTop = screenHeight * 0.0015;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Logout(),
      ),
      body: Column(
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              heightFactor: searchPaddingTop,
              child: const AutoSizeText(
                "Weather",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              child: CupertinoSearchTextField(
                backgroundColor: Colors.grey[300],
                controller: textController,
                onChanged: (value) async {
                  if (value.length >= 3 && flg == true) {
                    flg = false;
                    try {
                      final response =
                          await SearchApi(Dio()).fetchDataSearch(value);
                      setState(() {
                        searchSuggestions =
                            response; // Update search suggestions list
                      });
                    } catch (e) {
                      print(e);
                    } finally {
                      flg = true; // Reset flg to true
                    }
                  }
                },
                onSubmitted: (value) async {
                  setState(() {
                    searchValue = value;
                  });
                  try {
                    final response =
                        await WeatherGetApi(Dio()).fetchData(value);
                    if (response['location'] != null &&
                        response['location']['name'] != null &&
                        context.mounted) {
                      // final locationName = response['location']['name'];
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ShowWeatherModal(response: response);
                        },
                      );
                    }
                  } catch (e) {
                    print('Error fetching weather data: $e');
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = searchSuggestions[index];
                return ListTile(
                  title: Text(
                    "${suggestion['name']}${suggestion['region']}${suggestion['country']}",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Handle suggestion tapped
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
