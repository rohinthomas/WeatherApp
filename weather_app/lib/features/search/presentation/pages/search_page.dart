import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logout.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController(text: "search");
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
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
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
