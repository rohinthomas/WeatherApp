import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/search/presentation/widget/fav_city.dart';


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
    return FractionallySizedBox(
      // heightFactor: MediaQuery.of(context).size.height *0.05,
      
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            FractionallySizedBox(
              child: Padding(
                  padding: const EdgeInsets.only(top:8),
                  child: InkWell(
                    onTap: () {
                      context.go("/");
                    },
                    child: Card(
                        color: const Color.fromARGB(53, 32, 32, 32),
                        child: SizedBox(
                            width: screenWidth * 1,
                            height: screenHeight * 0.17,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height *0.7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AutoSizeText("My Location",
                                                   maxLines:1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w800)),
                                                      
                                              AutoSizeText(city,
                                               maxLines:1,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500))
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                condition,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                      height: MediaQuery.of(context).size.height *0.7,

                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                "$degree\u00B0",
                                                 maxLines:1,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              Image.network(
                                                "https:$image",
                                                width: screenWidth * 0.1,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ]))),
                  )),
            ),
      
           const FavLocation()
          ]),
    );
  }
}
