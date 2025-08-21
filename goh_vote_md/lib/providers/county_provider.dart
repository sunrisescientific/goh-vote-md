import 'package:flutter/material.dart';

class CountyProvider extends ChangeNotifier {
  String _selectedCounty = "County";

  String get selectedCounty => _selectedCounty;

  void setCounty(String newCounty) {
    _selectedCounty = newCounty;
    notifyListeners();
  }
}