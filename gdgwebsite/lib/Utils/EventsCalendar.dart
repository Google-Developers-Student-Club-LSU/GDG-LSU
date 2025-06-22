//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/UpcomingEvents.dart';
import 'package:intl/intl.dart';

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
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;

    double ratio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height * 0.8;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: MonthView<Event>(
            controller: _eventController,
            useAvailableVerticalSpace: false,
            initialMonth: DateTime.now(),
            showBorder: true,
            cellAspectRatio: ratio,
            headerStringBuilder: (date, {secondaryDate}) {
              return DateFormat('MMMM yyyy').format(date);
            },
            headerStyle: HeaderStyle(
              leftIconConfig: IconDataConfig(
                icon: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset('logo/GDSC.png', height: 32),
                ),
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  top: BorderSide(color: gYellow, width: 2),
                  left: BorderSide(color: gYellow, width: 2),
                  right: BorderSide(color: gYellow, width: 2),
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              headerTextStyle: StandardText.copyWith(fontSize: 20),
            ),
            cellBuilder: (date, events, isToday, isInMonth, hideDaysNotInMonth) {
              final cellColor = events.isNotEmpty ? gGreen : backgroundColor;

              return LayoutBuilder(
                builder: (context, cellConstraints) {
                  final base = cellConstraints.maxWidth < cellConstraints.maxHeight
                      ? cellConstraints.maxWidth
                      : cellConstraints.maxHeight;

                  final padding = base * 0.05;
                  final dayFontSize = base * 0.2;
                  final titleFontSize = base * 0.17;

                  return Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date.day.toString(),
                          style: StandardText.copyWith(fontSize: dayFontSize),
                        ),
                        if (events.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: padding),
                            child: Text(
                              events.first.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: StandardText.copyWith(fontSize: titleFontSize),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
            onCellTap: (date, events) {
              // Optional: Implement pop-up or navigation
            },
          ),
        );
      },
    );
  }
}