import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class CountyContact {
  final String phone;
  final String email;
  final String address;
  final String website;

  CountyContact({
    required this.phone,
    required this.email,
    required this.address,
    required this.website,
  });

  factory CountyContact.fromTsv(List<String> fields)
  {
    return CountyContact
    (
      phone: fields[1],
      email: fields[2],
      address: fields[3],
      website: fields[4],
    );
  }
}

class CountyProvider with ChangeNotifier {
  String _selectedCounty = "County"; 

  final Map<String, CountyContact> _countyContacts = {};

  String get selectedCounty => _selectedCounty;
  List<String> get counties => _countyContacts.keys.toList();

  CountyContact? get selectedCountyContact =>
      _countyContacts[_selectedCounty];

  Future<void> loadContacts() async
  {
    final raw = await rootBundle.loadString('assets/counties.tsv');
    final lines = const LineSplitter().convert(raw);

    for (var line in lines.skip(1))
    {
      final fields = line.split('\t');
      final countyName = fields[0];
      _countyContacts[countyName] = CountyContact.fromTsv(fields);
    }
    notifyListeners();
  }

  void setCounty(String county) {
    _selectedCounty = county;
    notifyListeners();
  }
}
