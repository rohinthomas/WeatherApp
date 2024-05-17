import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
      ),
      body: Column(children: [
        const Text("Discover The ",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w800
                    ),),
        const Text("Weather In Your City",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w800
                    ),),            
        Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 25),
          child: Image.asset("images/logo.png",),
        ),
      ),
      const Text("Get to know your weather maps and",
        style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 199, 199, 199),
        ),
      ),
      const Text("radar precipitation forecast",
        style: TextStyle(
          fontSize: 20,
          color:Color.fromARGB(255, 199, 199, 199),
        ),
      )
      ],)
      
    );
  }
}