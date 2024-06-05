import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/database/database_helper.dart';


class CustomPopupMenu {
  Widget menu({
    required List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder,
    Icon? icon,
    PopupMenuPosition menuPosition = PopupMenuPosition.under,
  }) {
    return PopupMenuButton(
      icon: icon,
      offset: Offset.zero,
      initialValue: null,
      tooltip: '',
      elevation: 8,
      padding: EdgeInsets.zero,
      color: const Color.fromARGB(53, 32, 32, 32), // Set the popup menu color
      itemBuilder: itemBuilder,
    );
  }

  PopupMenuEntry<dynamic> menuItem({
    required Text label,
    required Icon icon,
    required VoidCallback onPressed,
  }) {
    return PopupMenuItem(
      onTap: onPressed,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: icon,
          ),
          label,
        ],
      ),
    );
  }
}

class FavLocation extends StatefulWidget {
  const FavLocation({super.key});

  @override
  State<FavLocation> createState() => _FavLocationState();
}

class _FavLocationState extends State<FavLocation> {
  final DatabaseHelper _databaseHelper = DatabaseHelper(); // Instance of DatabaseHelper
  bool _isEditMode = false; // Track if the edit mode is active
  final CustomPopupMenu customPopupMenu = CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _databaseHelper.getCities(), // Fetch cities from the database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final citiesFromDB = snapshot.data!;
          return citiesFromDB.isNotEmpty
              ? FractionallySizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText(
                              "Favorite Cities",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.refresh, size: 20, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      // Call a function to refresh the favorite cities widget
                                      // You can implement this function to refetch data or perform any necessary operations to refresh the widget
                                      // For example:
                                      // _refreshFavoriteCities();
                                    });
                                  },
                                ),
                                Builder(
                                  builder: (BuildContext context) {
                                    return _isEditMode
                                        ? IconButton(
                                            icon: const Icon(Icons.done, size: 30, color: Colors.white),
                                            onPressed: () {
                                              setState(() {
                                                _isEditMode = false;
                                              });
                                            },
                                          )
                                        : customPopupMenu.menu(
                                            icon: const Icon(
                                              Icons.more_horiz_sharp,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            itemBuilder: (BuildContext context) => [
                                              customPopupMenu.menuItem(
                                                label: const Text('Edit Items', style: TextStyle(color: Colors.white)),
                                                icon: const Icon(Icons.edit, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditMode = !_isEditMode; // Toggle edit mode
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4821,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: citiesFromDB.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final cityName = citiesFromDB[index]['name'] as String;
                              debugPrint(cityName);
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => NewWeatherPage(location: cityName),
                                      //   ),
                                      // );
                                        final dynamic param = {
                                        "location": cityName.toString()
                                        };
                                        
                                        context.push(Uri(path:'/weather',queryParameters:param ).toString());
                                              },
                                    child: Card(
                                      color: const Color.fromARGB(53, 32, 32, 32),
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    cityName,
                                                    maxLines: 1,
                                                    minFontSize: 5,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_isEditMode)
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _removeCity(cityName); // Remove city from database
                                          });
                                        },
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(); // Return an empty container if there are no cities
        }
      },
    );
  }

  // Function to remove city from database
  Future<void> _removeCity(String cityName) async {
    // Call the database helper function to remove the city
    await _databaseHelper.deleteCity(cityName);
    // Force rebuild to reflect changes
    setState(() {});
  }
}

