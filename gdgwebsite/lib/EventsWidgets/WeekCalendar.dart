//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//


import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/EventsWidgets/EventCart.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/provider/EventProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
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

int weekNumber(DateTime date) {
  final firstDayOfYear = DateTime(date.year, 1, 1);
  final daysOffset = firstDayOfYear.weekday - DateTime.monday;
  final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
  final difference = date.difference(firstMonday).inDays;
  return (difference / 7).ceil() + 1;
}

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final isMobile = MediaQuery.of(context).size.width < 900;
    Color themeBackGround = isLightMode ? Colors.black.withValues(alpha: .4) : Colors.white70.withValues(alpha: .1);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * (isMobile ? 1 : 0.9),
            maxHeight: MediaQuery.of(context).size.height ,
          ),
          child:  WeekView<Event>(
            liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
              color: gYellow,
              showTime: true
            ),
            startHour: 7,
            endHour: 22,
            backgroundColor: themeBackGround,
            controller: _eventController,
            headerStringBuilder: (date, {secondaryDate}) {
              return DateFormat('MMMM yyyy').format(date);
            },
           timeLineBuilder: (DateTime date) {
            return Container(
              decoration: BoxDecoration() ,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Align(
                  alignment:isMobile ?  Alignment(1.0, -1.6):  Alignment(1.0, -2.7),
                  child: Text(
                    DateFormat.jm().format(date), 
                    style:   TextStyle(fontSize: isMobile ? 10 : 20,  fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            );
          },

          weekNumberBuilder: (DateTime firstDayOfWeek) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: gYellow, width: 1),
                  top: BorderSide(color: gYellow, width: 1),
                  right: BorderSide(color: gYellow, width: 1),
                  bottom: BorderSide(color: gYellow, width: 2),
                )
              ),
              child: Center(
                child: Text(
                  'Week ${weekNumber(firstDayOfWeek)}',
                  style: TextStyle(fontSize: isMobile ? 10 : 20,  fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            );
          },
            weekDayBuilder: (DateTime date) {
            return Container(
              decoration: BoxDecoration(
                border:  Border(
                  left: BorderSide(color: gYellow, width: 1),
                  top: BorderSide(color: gYellow, width: 1),
                  right: BorderSide(color: gYellow, width: 1),
                  bottom: BorderSide(color: gYellow, width: 2),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Text(
                    DateFormat.E().format(date),
                    style: TextStyle(fontSize: isMobile ? 10 : 20,  fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            );
          },
            onHeaderTitleTap: (date) async {},
            headerStyle: HeaderStyle(
              leftIconConfig: IconDataConfig(
                icon: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset(gDSCLogo, height: 32),
                ),
              ),
              decoration: BoxDecoration(
                color: themeBackGround,
                border: Border(
                  top: BorderSide(color: gYellow, width: 2),
                  left: BorderSide(color: gYellow, width: 2),
                  right: BorderSide(color: gYellow, width: 2),
                  bottom: BorderSide(color: gYellow, width: 2),
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              headerTextStyle: StandardText.copyWith(fontSize: 20, color: Colors.white),
            ),
            eventTileBuilder: (date, events, boundry, start, end) {
              return InkWell(
                onTapDown:(TapDownDetails details){
                   final tapDownDetails = details.globalPosition;
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
                            gallerUrl: events.first.event?.galleryUrl,
                            tapPosition: tapDownDetails,
                          ),
                    
                      );
                    }, 
                child: Container(
                  decoration: BoxDecoration(
                    color: (events.first.event?.color)?.withValues(alpha: isLightMode ? 0.9 : 0.7 )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: isMobile
                    ? 
                     Text(
                                events.first.title,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: StandardText.copyWith(fontSize: isMobile? 10: 17 , color: Colors.white, fontWeight: FontWeight.w600),
                              )
                      :
                     FittedBox(
                      child: Text(
                                events.first.title,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: StandardText.copyWith(fontSize: isMobile? 10: 17 , color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                    ),
                  ),
                ),
              ) ;
            }
          ),
                );
              },
          
            );
          }
}