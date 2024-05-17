import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Icon(Icons.search_outlined,color: Colors.white,),
        Text("Weather App",style: TextStyle(color: Colors.white,fontSize: 25),),
        Icon(Icons.person_2_rounded,color: Colors.white,),
        ],), 
        backgroundColor:const Color.fromARGB(255, 0, 0, 0),
        
      ),
    );
  }
}