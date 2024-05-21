import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WeatherUi extends StatelessWidget {
  const WeatherUi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        AutoSizeText("Kottayam",
            style:TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700
            ) ,
          ),    
          AutoSizeText("22"" \u2103",
            style:TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.w700
            ) ,
          ),
          AutoSizeText("Mostly Clear",
            style:TextStyle(
              color: Colors.white,
              fontSize: 24,
              // fontWeight: FontWeight.w700
            ) ,
          )        

      ], 
  ); 
  }
}