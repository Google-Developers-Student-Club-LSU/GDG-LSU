//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/EventsWidgets/EventCart.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/Utils/CacheEvents.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MonthCalendar extends StatefulWidget {
  const MonthCalendar({super.key});

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  late final EventController<Event> _eventController;
  bool _initialized = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (!_initialized) {
    final events = Provider.of<EventProvider>(context, listen: false).events;
    _eventController = CalendarControllerProvider.of<Event>(context).controller;
    _eventController.addAll(events);
    _initialized = true;
  }
}
  @override
  Widget build(BuildContext context) {

   
    double ratio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final isMobile = MediaQuery.of(context).size.width < 900;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
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
            onHeaderTitleTap: (date) async {},
            headerStyle: HeaderStyle(
              leftIconConfig: IconDataConfig(
                icon: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset('logo/GDSC.png', height: 32),
                ),
              ),
              decoration: BoxDecoration(
                color: (isLightMode ? Colors.black.withValues(alpha: .4) : Colors.white70.withValues(alpha: .1)),
                border: Border(
                  top: BorderSide(color: gYellow, width: 2),
                  left: BorderSide(color: gYellow, width: 2),
                  right: BorderSide(color: gYellow, width: 2),
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              headerTextStyle: StandardText.copyWith(fontSize: 20, color: Colors.white),
            ),
    cellBuilder: (date, events, isToday, isInMonth, hideDaysNotInMonth,) {
        hideDaysNotInMonth = true;
        Color? cellColor = events.isNotEmpty
            ? events.first.event?.color.withValues(alpha: isLightMode ? 0.9 : 0.7)
            : (isLightMode ? Colors.black.withValues(alpha: .4) : Colors.white70.withValues(alpha: .1));          
            return Container(
            decoration: BoxDecoration(
              color: cellColor,
              border: Border.all(color: Colors.white70),
            ),
            padding: const EdgeInsets.all(6),
            child: Stack(
              children: [
                // Day number in the top-left corner
                Positioned(
                  top: 0,
                  left: 0,
                  child: SelectableText(
                    date.day.toString(),
                    style: StandardText.copyWith(fontSize: 12, color: Colors.white),
                  ),
                ),
                // Centered event title (if any)
                if (events.isNotEmpty)
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) =>
                         EventCart(
                            title: events.first.title,
                            description: events.first.description ?? "No description",
                            start: events.first.startTime ?? DateTime.now(),
                            end: events.first.endTime ?? DateTime.now(),
                            image: events.first.event?.image,
                            color: events.first.event?.color ?? gYellow,
                            room: events.first.event?.room,
                          ),
                    
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FittedBox(
                          child: Text(
                            events.first.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: StandardText.copyWith(fontSize: isMobile ? 10 : 17 , color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
          
            // ignore: avoid_print
            onEventTap: (event, date) {
            } ,
          ),
        );
        
      },
    );
  }
}