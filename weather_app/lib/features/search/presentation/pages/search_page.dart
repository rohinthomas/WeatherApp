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
  
  const SearchPage({
    super.key,
    required this.city,
    required this.condition,
    required this.degree,
    required this.image,
  });

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  String? searchValue;
  List<dynamic> searchSuggestions = [];
  bool isSearchBarFocused = false;
  FocusNode searchFocusNode = FocusNode();
  bool isLoading = false;
  String searchBarText="";
  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(_onFocusChange);
    textController.addListener(() {
    if (textController.text.isEmpty) {
      setState(() {
        searchBarText = "";
        searchSuggestions = [];
      });
    }
  });
  }

  void _onFocusChange() {
    setState(() {
      isSearchBarFocused = searchFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    searchFocusNode.removeListener(_onFocusChange);
    searchFocusNode.dispose();
    super.dispose();
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingDialog() {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void onSubmit(String value) async {
    if (value.isEmpty) {
      isSearchBarFocused = false;
      searchFocusNode.unfocus();
      searchBarText="";
      return; // Do nothing if the search field is empty
    }

    setState(() {
      searchValue = value;
    });

    try {
      showLoadingDialog();
      final response = await WeatherGetApi(Dio()).fetchData(value);
      hideLoadingDialog();
      if (response['location'] != null &&
          response['location']['name'] != null &&
          mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ShowWeatherModal(response: response);
          },
        );
      }
    } catch (e) {
      hideLoadingDialog();
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    double searchPaddingTop = screenHeight * 0.0015;
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Logout(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: searchPaddingTop),
              child: const AutoSizeText(
                "Weather",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      backgroundColor: Colors.grey[300],
                      controller: textController,
                      focusNode: searchFocusNode,
                      onChanged: (value) async {
                        if (value.isNotEmpty && isSearchBarFocused) {
                          try {
                            final response =
                                await SearchApi(Dio()).fetchDataSearch(value);
                            setState(() {
                              searchSuggestions = response;
                              searchBarText=value;
                              print(searchBarText);
                            });
                            if (response.isEmpty) {
                              setState(() {
                                searchSuggestions = [];
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      onTap: () {
                        setState(() {
                          isSearchBarFocused = true;
                        });
                      },
                      onSubmitted: onSubmit,
                      
                    ),
                  ),
                  Visibility(
                    visible: isSearchBarFocused,
                    child: CupertinoButton(
                      child: const AutoSizeText(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          textController.clear();
                          searchSuggestions.clear();
                          isSearchBarFocused = false;
                          searchFocusNode.unfocus();
                          searchBarText="";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: searchSuggestions.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = searchSuggestions[index];
                        return ListTile(
                          title: AutoSizeText(
                            "${suggestion['name']}, ${suggestion['region']}, ${suggestion['country']}",
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () async {
                            String selectedValue = suggestion['name'];
                            setState(() {
                              searchValue = selectedValue;
                              textController.text = selectedValue;
                            });

                            try {
                              showLoadingDialog();
                              final response = await WeatherGetApi(Dio())
                                  .fetchData(selectedValue);
                              hideLoadingDialog();
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
                              hideLoadingDialog();
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
                  : SingleChildScrollView(
                      child: searchBarText.isNotEmpty && searchSuggestions.isEmpty
                          ?  const Center(
                            child: Text(
                                "No city found",
                                style: TextStyle(color: Colors.white),
                              ),
                          )
                          : FavCity(
                              city: widget.city,
                              condition: widget.condition,
                              degree: widget.degree,
                              image: widget.image,
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
