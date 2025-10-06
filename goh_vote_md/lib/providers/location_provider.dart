import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class LocationProvider with ChangeNotifier
{
  List<Map<String, String>> dropboxLocations = [];
  List<Map<String, String>> earlyLocations = [];
  List<Map<String, String>> pollingLocations = [];

  LocationProvider()
  {
    fetchDropBoxData();
    fetchEarlyData();
    fetchPollingData();
  }

  Future<List<Map<String, String>>> fetch(String url) async
  {
    try
    {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200)
      {
        final csvTable = const CsvToListConverter().convert(response.body);
        final rows = csvTable.skip(1);

        final List<Map<String, String>> loadedLocations = [];

        for (var row in rows)
        {
          loadedLocations.add
          (
            {
              "county": row[0],
              "name": row[1],
              "address": row[2],
              "lat": row[3].toString(),
              "lng": row[4].toString(),
            }
          );
        }

        return loadedLocations;
      }
      else
      {
        print("Failed to fetch CSV from $url, status: ${response.statusCode}");
      }
    }
    catch (e)
    {
      print("Error fetching data from $url: $e");
    }

    return [];
  }

  Future<void> fetchDropBoxData() async
  {
    dropboxLocations = await fetch
    (
      "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=1672957303",
    );
    notifyListeners();
  }

  Future<void> fetchEarlyData() async
  {
    earlyLocations = await fetch
    (
      "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=439321169",
    );
    notifyListeners();
  }

  Future<void> fetchPollingData() async
  {
    pollingLocations = await fetch
    (
      "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=458374181",
    );
    notifyListeners();
  }
}
