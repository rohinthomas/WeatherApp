import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FutureWeatherCard extends StatelessWidget {
  final dynamic response;
  const FutureWeatherCard({super.key,required this.response});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final date=response['date'];
    DateTime dateTime = DateTime.parse(date);
    final dayFormatter = DateFormat('EEEE');
    final day=dayFormatter.format(dateTime);
    return  Padding(
      padding: const EdgeInsets.only(top: 6),
      
      child: Container(
        color: const Color.fromARGB(0, 255, 255, 255),
        child: SizedBox(
              width:screenWidth *0.9,
              height: screenHeight *0.06,             
              child:Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(day,style:const TextStyle(color: Colors.white,
                              fontSize: 15, 
                      ),),
                        Row(children: [
                          Column(children: [
                          Image.network("https:${response['day']['condition']['icon']}",width: screenHeight * 0.04,),
                          if (response['day']['daily_chance_of_rain'] != 0)
                          AutoSizeText(
                            "${response['day']['daily_chance_of_rain']}%",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 174, 255),
                              fontSize: 10,
                            ),
                          ),

                          ],),
                          AutoSizeText("  ${response['day']['avgtemp_c']}\u00B0",style:const TextStyle(color: Colors.white,
                              fontSize: 15, 
                      ),
                      )
                      ],
                      )
                      ],
                    )
                  ],                 
              ),
        ),
      ),
    );
  }
}