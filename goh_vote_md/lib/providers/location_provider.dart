import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class LocationProvider with ChangeNotifier
{
  String gid = "1007280262";

  List<Map<String, String>> dropboxLocations = [];
  List<Map<String, String>> earlyLocations = [];
  List<Map<String, String>> pollingLocations = [];

  LocationProvider()
  {
    //fetchDropBoxData();
    //fetchEarlyData();
    fetchPollingData();
  }

  Future<void> fetchDropBoxData() async
  {
    try
    {
      final url = Uri.parse
      (
        "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=1007280262"
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final csvTable = const CsvToListConverter().convert(response.body);

        final rows = csvTable.skip(1);

        final List<Map<String, String>> loadedLocations = [];

        for (var row in rows)
        {
          try
          {
            final results = await locationFromAddress(row[2].toString());
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
                "lat": results.first.latitude.toString(),
                "lng": results.first.longitude.toString(),
              }
            );
          }
          catch(e)
          {
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
              }
            );
          }
        }

        dropboxLocations = loadedLocations;

        notifyListeners();
      }
    }
    catch (e)
    {
      print("Error fetching county data: $e");
    }
  }

  Future<void> fetchEarlyData() async
  {
    try
    {
      final url = Uri.parse
      (
        "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=439321169"
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final csvTable = const CsvToListConverter().convert(response.body);

        final rows = csvTable.skip(1);

        final List<Map<String, String>> loadedLocations = [];

        for (var row in rows)
        {
          try
          {
            final results = await locationFromAddress(row[2].toString());
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
                "lat": results.first.latitude.toString(),
                "lng": results.first.longitude.toString(),
              }
            );
          }
          catch(e)
          {
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
              }
            );
          }
        }

        earlyLocations = loadedLocations;

        notifyListeners();
      }
    }
    catch (e)
    {
      print("Error fetching county data: $e");
    }
  }

  Future<void> fetchPollingData() async
  {
    try
    {
      final url = Uri.parse
      (
        "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=458374181"
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final csvTable = const CsvToListConverter().convert(response.body);

        final rows = csvTable.skip(1);

        final List<Map<String, String>> loadedLocations = [];

        for (var row in rows)
        {
          try
          {
            final results = await locationFromAddress(row[2].toString());
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
                "lat": results.first.latitude.toString(),
                "lng": results.first.longitude.toString(),
              }
            );
          }
          catch(e)
          {
            loadedLocations.add
            (
              {
                "name": row[1],
                "address": row[2],
              }
            );
          }
        }

        pollingLocations = loadedLocations;

        notifyListeners();
      }
    }
    catch (e)
    {
      print("Error fetching county data: $e");
    }
  }
}