import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/features/weather/presentation/widget/weather_ui.dart';


class ShowWeatherModal extends StatelessWidget {
  final String locationName;
  const ShowWeatherModal({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Container(
  color: Colors.black,
  child: FractionallySizedBox(
    heightFactor: 0.92,
    widthFactor: 1,
    child: Center(
      child:Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Flexible( 
            child:  Align(
              alignment:Alignment.topLeft,
              child: TextButton(
               child: const AutoSizeText('Add',
                 style:TextStyle(
                    color:Colors.white,
                    fontSize:18,
                    )
                ),
               onPressed: () => {},
               ),
              ),
              
          ),
          Flexible(
            child:Align(
              alignment:Alignment.topRight,
              child: TextButton(
                child: const AutoSizeText('Cancel',
                  style:TextStyle(
                    color:Colors.white,
                    fontSize: 18,
                    )
                  ),
                onPressed: () => Navigator.pop(context),
              ),
            )  
          ),
          
          
        ],
      ),
      // Text('"Weather in $locationName"',style: const TextStyle(color:Colors.white),),
      const WeatherUi()
      ],

      )
    ),
  ),
);
    
    
    
    // Container(
    //   color: const Color.fromARGB(255, 255, 255, 255),
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         "Weather in $locationName",
    //         style: const TextStyle(
    //           color:  Color.fromARGB(255, 0, 0, 0),
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(height: 10),
    //      const Text(
    //         "Detailed weather information goes here...",
    //         style: TextStyle(
    //           color: const Color.fromARGB(255, 35, 35, 35),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}