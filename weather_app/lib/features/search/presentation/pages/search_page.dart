import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/search/data/api_/weather_get_api.dart';
import 'package:weather_app/features/search/presentation/widget/fav.dart';
import 'package:weather_app/features/search/presentation/widget/show_weather_modal.dart';
import 'package:weather_app/logout.dart';

class SearchPage extends StatefulWidget {
  final String city;
  final String condition;
  final String degree;
  final String image;
  const SearchPage({super.key,required this.city,required this.condition,required this.degree,required this.image});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  String? searchValue;
  List<dynamic> searchSuggestions = [];
  bool isSearchBarFocused = false;
  FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

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
              heightFactor: screenHeight *0.0011,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      backgroundColor: Colors.grey[300],
                      controller: textController,
                      onChanged: (value) async {
                         setState(() {
                              // searchSuggestions = response;
                              isSearchBarFocused = true;
                            });
                        if (value.length >= 3 && isSearchBarFocused) {

                          try {
                            final response =
                                await SearchApi(Dio()).fetchDataSearch(value);
                            setState(() {
                              searchSuggestions = response;
                              // isSearchBarFocused = true;
                            });
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      focusNode: searchFocusNode,
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
                  Visibility(
                    visible: isSearchBarFocused,
                    child: CupertinoButton(
                      child: const AutoSizeText('Cancel',style:TextStyle(color:Colors.white,fontSize: 16.5)),
                      onPressed: () {
                        setState(() {
                          textController.clear();
                          searchSuggestions.clear();
                          isSearchBarFocused = false;
                          searchFocusNode.unfocus();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: searchSuggestions.isNotEmpty
                ? ListView.builder(
                    itemCount: searchSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = searchSuggestions[index];
                      return ListTile(
                        title: Text(
                          "${suggestion['name']}, ${suggestion['region']}, ${suggestion['country']}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                          String selectedValue = suggestion['name'];
                          setState(() {
                            searchValue = selectedValue;
                            textController.text = selectedValue;
                          });

                          try {
                            final response = await WeatherGetApi(Dio())
                                .fetchData(selectedValue);
                            if (response['location'] != null &&
                                response['location']['name'] != null &&
                                mounted) {
                              if (context.mounted) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return ShowWeatherModal(
                                        response: response);
                                  },
                                );
                              }
                            }
                          } catch (e) {
                            print('Error fetching weather data: $e');
                          } finally {
                            setState(() {
                              searchSuggestions.clear();
                            });
                          }
                        },
                      );
                    },
                  )
                : FavCity(city:widget.city,condition: widget.condition,degree:widget.degree,image:widget.image)
          ),
        ],
      ),
    );
  }
}
