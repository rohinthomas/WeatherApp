import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/search/presentation/pages/search_page.dart';
import 'package:weather_app/logout.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double mainTextWidth=screenWidth*0.4;
    return Scaffold(
      appBar: AppBar(
        
        title:Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Flexible(
                
                child: Align(
                        alignment: Alignment.topLeft,
                        child: 
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchPage())
                            );
                          },
                        child: const Icon(Icons.search_outlined, color: Colors.white), // Corrected syntax
                         
                        )
                      ),
                
    
              ),
              SizedBox(
                 width: mainTextWidth,
                 child: const Align(
                 alignment: Alignment.center,
                 child: AutoSizeText(
                  "Weather App",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  maxLines: 1,
                ),
              ),
            ),
                    const Expanded(
                      child: Logout(),
                    ),
        ],), 
        backgroundColor:const Color.fromARGB(255, 0, 0, 0),
        
      ),
      backgroundColor: Colors.black,

    );
  }
}