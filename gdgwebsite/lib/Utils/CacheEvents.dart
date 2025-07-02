import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Models/EventModel.dart';

class EventProvider with ChangeNotifier {
  List<CalendarEventData<Event>> _events = [];

  List<CalendarEventData<Event>> get events => _events;

  void loadEvents(List<Map<String, dynamic>> rawData) {
    _events = rawData.map((e) {
      final start = e['date'] as DateTime;
      final end = e['endDate'] as DateTime;
      final title = e['title'] as String;
      final description = e['description'] as String;
      final image = e['image'] as String?;
      final room = e['room'] as String?;
      final color = e['color'] as Color;

      return CalendarEventData<Event>(
        date: start,
        startTime: start,
        endTime: end,
        title: title,
        description: description,
        color: color,
        event: Event(
          title: title,
          description: description,
          image: image,
          room: room,
          color: color,
        ),
      );
    }).toList();

    notifyListeners();
  }
}
