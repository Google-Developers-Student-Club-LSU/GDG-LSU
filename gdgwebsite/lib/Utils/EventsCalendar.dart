//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/Utils/CacheEvents.dart';
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
    _eventController.addAll(parseEvents());
    _initialized = true;
  }
}
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;

    double ratio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height * 0.8;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth:   MediaQuery.of(context).size.width * 0.8,
            maxHeight:  MediaQuery.of(context).size.height ,
          ),
          child: MonthView<Event>(
            hideDaysNotInMonth: true,
            controller: _eventController,
            useAvailableVerticalSpace: true,
            initialMonth: DateTime.now(),
            showBorder: true,
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
  final cellColor = events.isNotEmpty ? events.first.event?.color : backgroundColor;

  return Container(
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: gBlue),
    ),
    padding: const EdgeInsets.all(6),
    child: Stack(
      children: [
        // Day number in the top-left corner
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            date.day.toString(),
            style: StandardText.copyWith(fontSize: 12),
          ),
        ),
        // Centered event title (if any)
        if (events.isNotEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only (top: 4.0),
                  child: FittedBox(
                    child: Text(
                    events.first.title,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: StandardText.copyWith(fontSize: 20 , fontWeight: FontWeight.w500),
                                    ),
                  ),
              
            ),
          ),
      ],
    ),
  );
},
          ),
        );
      },
    );
  }
}