import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

class ElectionEvent
{
  final String name;
  final DateTime date;
  final DateTime earlyStart;
  final DateTime earlyEnd;

  ElectionEvent
  ({
    required this.name,
    required this.date,
    required this.earlyStart,
    required this.earlyEnd,
  });
}


class CalendarProvider with ChangeNotifier
{
  String gid = "1916710181";

  List<ElectionEvent> calendarEvents = [];

  CalendarProvider()
  {
    fetchCalendarData();
  }

  DateTime parseDate(String dateStr)
  {
    final dateFormatter = DateFormat("EEEE, MMMM dd, yyyy");
    final parsedDate = dateFormatter.parse(dateStr);
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day, 7);
  }

  Future<void> fetchCalendarData() async
  {
    try
    {
      final url = Uri.parse
      (
        "https://docs.google.com/spreadsheets/d/1POThZzWf2AmqmtxBqVz5VPOc1eZb5TP-vKj2adXb0ag/export?format=csv&gid=1916710181"
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final csvTable = const CsvToListConverter().convert(response.body);

        final rows = csvTable.skip(1);

        final List<ElectionEvent> loadedEvents = [];

        for (var row in rows)
        {
          loadedEvents.add
          (
            ElectionEvent
            (
              name: row[0].toString().trim(),
              date: parseDate(row[1].toString().trim()),
              earlyStart: parseDate(row[3].toString().trim()),
              earlyEnd: parseDate(row[4].toString().trim()),
            )
          );
        }

        calendarEvents = loadedEvents;

        notifyListeners();
      }
    }
    catch (e)
    {
      print("Error fetching county data: $e");
    }
  }
}