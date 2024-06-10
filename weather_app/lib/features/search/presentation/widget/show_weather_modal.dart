import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_state.dart';
import 'package:weather_app/database/database_helper.dart';
import 'package:weather_app/features/weather/presentation/widget/weather_ui.dart';

class ShowWeatherModal extends StatefulWidget {
  final dynamic response;

  const ShowWeatherModal({super.key, required this.response});

  @override
  ShowWeatherModalState createState() => ShowWeatherModalState();
}

class ShowWeatherModalState extends State<ShowWeatherModal> {
  late String locationName;
  bool isCityAdded = false;

  @override
  void initState() {
    super.initState();
    locationName = "${widget.response['location']['name']},${widget.response['location']['region']},${widget.response['location']['country']}";
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
    if(mounted){
    context.read<AppState>().updateCity(locationName);
    }
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
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      WeatherUi(response: widget.response),
                    ],
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
