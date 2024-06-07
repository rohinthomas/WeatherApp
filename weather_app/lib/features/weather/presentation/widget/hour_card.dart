import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class Hourcard extends StatelessWidget {
  final dynamic response;
  const Hourcard({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    String dateTimeString = response['time'].toString();
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat.jm().format(dateTime);
    return  Padding(
      padding: const EdgeInsets.all(7.0),
      
      child: Container(
        color: const Color.fromARGB(0, 255, 255, 255),
        child: SizedBox(
              width:screenWidth *0.2,             
              child:Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    AutoSizeText(" $time" ,
                        style:const TextStyle(color: Colors.white,
                              fontSize: 15, 
                      ),
                      minFontSize: 5,
                    ),
                    Image.network(
                      errorBuilder: (context, error, stackTrace) =>
                      Image(image:MemoryImage(kTransparentImage)) 
                      ,"https:${response['condition']['icon']}",width: screenWidth * 0.1,),
                    AutoSizeText(" ${response['temp_c']}\u00B0",
                      style: const TextStyle(color:Colors.white,
                           fontSize: 15,
                      ),
                      minFontSize: 5,
                    )
                  ],
              ),
        ),
      ),
    );
  }
}