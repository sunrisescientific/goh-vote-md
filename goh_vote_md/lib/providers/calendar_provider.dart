import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

class ElectionEvent
{
  final String name;
  final DateTime start;
  final DateTime end;

  ElectionEvent
  ({
    required this.name,
    required this.start,
    required this.end,
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

  DateTime parseDate(String dateStr, String timeStr)
  {
    final dateFormatter = DateFormat("EEEE MMMM dd yyyy h:mm a");
    final parsedDate = dateFormatter.parse("$dateStr $timeStr");
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day, parsedDate.hour, parsedDate.minute);
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
          if (row[0].toString() == '')
          {
            break;
          }
          // If missing start time but has end time, default start is 7:00 am.
          else if (row[2].toString() == '' && row[3].toString() != '')
          {
            DateTime tempEnd = parseDate(row[1].toString().trim(), row[3].toString().trim());
            DateTime tempStart = tempEnd.subtract(Duration(hours: 1));
            loadedEvents.add
            (
              ElectionEvent
              (
                name: row[0].toString().trim(),
                start: tempStart,
                end: tempEnd,
              )
            );
          }
          // If missing both start and end time, default start is 7:00 am and end is 8:00 pm.
          else if (row[2].toString() == '' && row[3].toString() == '')
          {
            loadedEvents.add
            (
              ElectionEvent
              (
                name: row[0].toString().trim(),
                start: parseDate(row[1].toString().trim(), "7:00 AM"),
                end: parseDate(row[1].toString().trim(), "8:00 PM"),
              )
            );
          }
          // If not missing anything, perfect.
          else
          {
            loadedEvents.add
            (
              ElectionEvent
              (
                name: row[0].toString().trim(),
                start: parseDate(row[1].toString().trim(), row[2].toString().trim()),
                end: parseDate(row[1].toString().trim(), row[3].toString().trim()),
              )
            );
          }
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