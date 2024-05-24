import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page_.dart';

class FavCity extends StatelessWidget {
  final String city;
  final String condition;
  final String degree;
  final String image;
  const FavCity(
      {super.key,
      required this.city,
      required this.condition,
      required this.degree,
      required this.image});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
  onTap: () {
    // Define the action to be taken when the card is tapped.
   Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherPageCity(location: city,)),
                    );
  },
     child:Card(
            color: const Color.fromARGB(53, 32, 32, 32),
            child: SizedBox(
              width: screenWidth * 1,
              height: screenHeight * 0.13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                           
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              const AutoSizeText("My Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)),
                            AutoSizeText(city,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))
                              ],
                              
                             ), 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               AutoSizeText(condition,
                               style:const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                               ),)
                            ],)           
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText("$degree\u00B0",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w500
                        ),),
                    Image.network("https:$image",width: screenWidth * 0.1,),

                    ],)
                  ],),
                )
              ])
        
            )),
        ))
    ]);
  }
}
