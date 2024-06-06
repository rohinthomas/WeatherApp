import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // Define your state variables and methods here
  String _city = "city";
  
  String get city => _city;
  
  void updateCity(String newCity) {
    _city = newCity;
    notifyListeners();
  }
}
