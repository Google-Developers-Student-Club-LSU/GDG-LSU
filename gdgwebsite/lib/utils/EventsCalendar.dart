//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/UpcomingEvents.dart';

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({super.key});

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  late final EventController<Event> _eventController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _eventController = CalendarControllerProvider.of<Event>(context).controller;

      final List<CalendarEventData<Event>> parsedEvents = myEvents.map((e) {
        final start = e['date'] as DateTime;
        final end = e['endDate'] as DateTime;
        final title = e['title'] as String;
        final description = e['description'] as String;
        final image = e['image'] as String?;

        final event = Event(title: title, description: description, image: image);

        return CalendarEventData<Event>(
          date: start,
          startTime: start,
          endTime: end,
          title: title,
          description: description,
          event: event,
        );
      }).toList();

      _eventController.addAll(parsedEvents);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MonthView<Event>(
      controller: _eventController,
      initialMonth: DateTime.now(),
      showBorder: true,
      cellAspectRatio: 1.2,
      onCellTap: (date, events) {
        // TODO: Implement show dialog or navigation
      },
    );
  }
}
