import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/database/database_helper.dart';
import 'package:weather_app/features/weather/presentation/widget/weather_ui.dart';

class ShowWeatherModal extends StatefulWidget {
  final dynamic response;

  const ShowWeatherModal({Key? key, required this.response}) : super(key: key);

  @override
  _ShowWeatherModalState createState() => _ShowWeatherModalState();
}

class _ShowWeatherModalState extends State<ShowWeatherModal> {
  late String locationName;
  bool isCityAdded = false;

  @override
  void initState() {
    super.initState();
    locationName = widget.response['location']['name'];
    _checkIfCityAlreadyAdded();
  }

  Future<void> _checkIfCityAlreadyAdded() async {
    final List<Map<String, dynamic>> cities = await DatabaseHelper().getCities();
    final bool isAdded = cities.any((city) => city['name'] == locationName);
    setState(() {
      isCityAdded = isAdded;
    });
  }

  Future<void> _addCity() async {
    await DatabaseHelper().insertCity(locationName);
    setState(() {
      isCityAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FractionallySizedBox(
        heightFactor: 0.92,
        widthFactor: 1,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isCityAdded)
                    Flexible(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          child: const AutoSizeText(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            await _addCity();
                          },
                        ),
                      ),
                    ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: const AutoSizeText(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: WeatherUi(response: widget.response)),
            ],
          ),
        ),
      ),
    );
  }
}
