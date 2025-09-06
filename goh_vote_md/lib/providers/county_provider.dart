import 'package:flutter/material.dart';

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
  String _selectedCounty = "County"; 

  final Map<String, CountyContact> _countyContacts = {
    "Montgomery": CountyContact(
      phone: "Montgomery phone",
      email: "Montgomery email",
      address: "Montgomery address",
      website: "Montgomery website",
    ),
    "Prince George's": CountyContact(
      phone: "Prince George's phone",
      email: "Prince George's email",
      address: "Prince George's address",
      website: "Prince George's website",
    ),
    "Baltimore": CountyContact(
      phone: "Baltimore phone",
      email: "Baltimore email",
      address: "Baltimore address",
      website: "Baltimore website",
    ),
    "Howard": CountyContact(
      phone: "Howard phone",
      email: "Howard email",
      address: "Howard address",
      website: "Howard website",
    ),
    "Harford": CountyContact(
      phone: "Harford phone",
      email: "Harford email",
      address: "Harford address",
      website: "Harford website",
    ),
    "Caroline": CountyContact(
      phone: "Caroline phone",
      email: "Caroline email",
      address: "Caroline address",
      website: "Caroline website",
    ),
    "Cecil": CountyContact(
      phone: "Cecil phone",
      email: "Cecil email",
      address: "Cecil address",
      website: "Cecil website",
    ),
    "St. Mary's": CountyContact(
      phone: "St. Mary's phone",
      email: "St. Mary's email",
      address: "St. Mary's address",
      website: "St. Mary's website",
    ),
    "Charles": CountyContact(
      phone: "Charles phone",
      email: "Charles email",
      address: "Charles address",
      website: "Charles website",
    ),
    "Worcester": CountyContact(
      phone: "Worcester phone",
      email: "Worcester email",
      address: "Worcester address",
      website: "Worcester website",
    ),
    "Washington": CountyContact(
      phone: "Washington phone",
      email: "Washington email",
      address: "Washington address",
      website: "Washington website",
    ),
    "Talbot": CountyContact(
      phone: "Talbot phone",
      email: "Talbot email",
      address: "Talbot address",
      website: "Talbot website",
    ),
    "Frederick": CountyContact(
      phone: "Frederick phone",
      email: "Frederick email",
      address: "Frederick address",
      website: "Frederick website",
    ),
    "Anne Arundel": CountyContact(
      phone: "Anne Arundel phone",
      email: "Anne Arundel email",
      address: "Anne Arundel address",
      website: "Anne Arundel website",
    ),
    "Carroll": CountyContact(
      phone: "Carroll phone",
      email: "Carroll email",
      address: "Carroll address",
      website: "Carroll website",
    ),
    "Allegany": CountyContact(
      phone: "Allegany phone",
      email: "Allegany email",
      address: "Allegany address",
      website: "Allegany website",
    ),
    "Kent": CountyContact(
      phone: "Kent phone",
      email: "Kent email",
      address: "Kent address",
      website: "Kent website",
    ),
    "Queen Anne's": CountyContact(
      phone: "Queen Anne's phone",
      email: "Queen Anne's email",
      address: "Queen Anne's address",
      website: "Queen Anne's website",
    ),
    "Calvert": CountyContact(
      phone: "Calvert phone",
      email: "Calvert email",
      address: "Calvert address",
      website: "Calvert website",
    ),
    "Dorchester": CountyContact(
      phone: "Dorchester phone",
      email: "Dorchester email",
      address: "Dorchester address",
      website: "Dorchester website",
    ),
  };

  String get selectedCounty => _selectedCounty;
  List<String> get counties => _countyContacts.keys.toList();

  CountyContact? get selectedCountyContact =>
      _countyContacts[_selectedCounty];

  void setCounty(String county) {
    _selectedCounty = county;
    notifyListeners();
  }
}
