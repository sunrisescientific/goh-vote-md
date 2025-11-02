import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import '../data/constants.dart';

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
}

class CountyProvider with ChangeNotifier {
  String gid = "521511549";
  String _selectedCounty = "County";
  static const String _countyKey = "selectedCounty";

  Map<String, CountyContact> _countyContacts = {};

  String get selectedCounty => _selectedCounty;
  List<String> get counties => _countyContacts.keys.toList();
  CountyContact? get selectedCountyContact => _countyContacts[_selectedCounty];

  CountyProvider() {
    fetchCountyData();
  }

  Future<void> _loadCounty() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCounty = prefs.getString(_countyKey);

    if (savedCounty != null && _countyContacts.containsKey(savedCounty)) {
      _selectedCounty = savedCounty;
      notifyListeners();
    }
  }

  Future<void> setCounty(String county) async {
    _selectedCounty = county;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_countyKey, county);
  }

  Future<void> fetchCountyData() async {
    try {
      final url = Uri.parse(sheetsURLStart + gid + sheetsURLEnd);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final csvTable = const CsvToListConverter().convert(response.body);
        final rows = csvTable.skip(1);

        final Map<String, CountyContact> loadedContacts = {};

        for (var row in rows) {
          if (row.length < 5) continue;

          final countyName = row[0].toString().trim();
          loadedContacts[countyName] = CountyContact(
            phone: row[1].toString().trim(),
            email: row[2].toString().trim(),
            website: row[3].toString().trim(),
            address: row[4].toString().trim(),
          );
        }

        _countyContacts = loadedContacts;

        await _loadCounty();
        if (!_countyContacts.containsKey(_selectedCounty) &&
            _countyContacts.isNotEmpty) {
          _selectedCounty = _countyContacts.keys.first;
        }

        notifyListeners();
      }
    } catch (e) {
      print("Error fetching county data: $e");
    }
  }
}
