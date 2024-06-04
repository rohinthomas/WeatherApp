import 'package:flutter/material.dart';
import 'package:weather_app/features/search/presentation/pages/search_page.dart';

class SearchPageRoute extends Page {
  final String city;
  final String condition;
  final String degree;
  final String image;

  const SearchPageRoute({
    required this.city,
    required this.condition,
    required this.degree,
    required this.image,
  });

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (BuildContext context){
       print(city);
       return SearchPage(
        city: city,
        condition: condition,
        degree: degree,
        image: image,
      );
      }
      
    );
  }
}
