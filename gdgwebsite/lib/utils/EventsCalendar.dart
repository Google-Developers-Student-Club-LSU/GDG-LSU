//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
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
      headerStyle: HeaderStyle(
        decoration: BoxDecoration(
          color: gYellow,
        ),
        headerTextStyle: StandardText.copyWith(fontSize: 20)
        
      ),
      cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth) {
      Color cellColor = Colors.white; // Default color
        
         if (event.isNotEmpty) {
          cellColor = gGreen; // Indicate presence of events
        }
        return Container(
      decoration: BoxDecoration(
        color: cellColor,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(date.day.toString()), // Display the day number
          if (event.isNotEmpty) // Display indicators or icons for events
            Icon(Icons.event_available_rounded, size: 12, color: Colors.deepPurple), // Use your own icon or event representation
        ],
      ),
    );
      },
      onCellTap: (date, events) {
        // TODO: Implement show dialog or navigation
      },
    );
  }
}
