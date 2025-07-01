




import 'dart:ui';
import 'package:calendar_view/calendar_view.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Models/EventModel.dart';

List<CalendarEventData<Event>>? _cachedParsedEvents;

List<CalendarEventData<Event>> parseEvents() {
  if (_cachedParsedEvents != null) return _cachedParsedEvents!;

  _cachedParsedEvents = myEvents.map((e) {
    final start = e['date'] as DateTime;
    final end = e['endDate'] as DateTime;
    final title = e['title'] as String;
    final description = e['description'] as String;
    final image = e['image'] as String?;
    final room = e['room'] as String?;
    final color = e['color'] as Color;

    final event = Event(
      title: title,
      description: description,
      image: image,
      color: color,
      room: room,
    );

    return CalendarEventData<Event>(
      date: start,
      startTime: start,
      endTime: end,
      title: title,
      description: description,
      event: event,
      color: color,
    );
  }).toList();

  return _cachedParsedEvents!;
}

