import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
import 'package:weather_app/logout.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  String? searchValue;

  @override
  Widget build(BuildContext context) {
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
                "Search",
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
                onSubmitted:(value){
                   setState(() {
                    searchValue = value;
                    // WeatherGetApi(
                    //   Dio()
                    // ).
                });  
                },
              ),
            ),
          ),
          Text("Search value: $searchValue"), // Display the search value
        ],
      ),
    );
  }
}
