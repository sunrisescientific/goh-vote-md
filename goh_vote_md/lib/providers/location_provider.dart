import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class LocationProvider with ChangeNotifier
{
  List<Map<String, String>> dropboxLocations = [];
  List<Map<String, String>> earlyLocations = [];

  bool isLoading = false;

  Future<void> initialize() async
  {
    isLoading = true;
    notifyListeners();

    await Future.wait
    ([
      fetchDropBoxData(),
      fetchEarlyData(),
    ]);

    isLoading = false;
    notifyListeners();
  }

  Future<List<Map<String, String>>> fetch(String csvFile) async
  {
    try
    {
        final String csvData = await rootBundle.loadString(csvFile);
        final cleaned = csvData.replaceAll('\r', '').replaceAll('\uFEFF', '');
        final csvTable = const CsvToListConverter(eol: '\n').convert(cleaned);
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
    catch (e)
    {
      print("Error fetching data from $csvFile: $e");
    }

    return [];
  }

  Future<void> fetchDropBoxData() async
  {
    dropboxLocations = await fetch("assets/dropbox.csv");
    notifyListeners();
  }

  Future<void> fetchEarlyData() async
  {
    earlyLocations = await fetch("assets/early.csv");
    notifyListeners();
  }
}
