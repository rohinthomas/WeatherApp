import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:weather_app/features/login/presentation/widget/googlesigninbutton.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double textSizeHeading = screenWidth * 0.081;
    double logoPadingTop=screenHeight*0.04;
    double logoPadingBottom=screenHeight*0.01;
    double textSizeBottom = screenWidth * 0.045;
    double textPadingBottom=screenHeight*0.01;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
      ),
      body: Column(children: [
         Text("Discover The ",
                    style: TextStyle(
                      fontSize: textSizeHeading,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w800
                    ),),
        Text("Weather In Your City",
                    style: TextStyle(
                      fontSize: textSizeHeading,
                      color: Colors.white,
                      fontWeight: FontWeight.w800
                    ),),            
        Center(
        child: Padding(
          padding:  EdgeInsets.only(top: logoPadingTop ,bottom: logoPadingBottom),
          child: Image.asset("images/logo.png",),
        ),
      ),
       Text("Get to know your weather maps and",
        style: TextStyle(
          fontSize: textSizeBottom,
          color: const Color.fromARGB(255, 199, 199, 199),
        ),
      ),
       Text("radar precipitation forecast",
        style: TextStyle(
          fontSize: textSizeBottom,
          color:const Color.fromARGB(255, 199, 199, 199),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(top: textPadingBottom),
        child: const Googlesigninbutton(),
      )
      ],)
      
    );
  }
}