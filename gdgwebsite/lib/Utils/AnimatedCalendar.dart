import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/Utils/EventsCalendar.dart';

class AnimatedCalendar extends StatefulWidget {
  const AnimatedCalendar({super.key});

  @override
  State<AnimatedCalendar> createState() => _AnimatedCalendarState();
}

class _AnimatedCalendarState extends State<AnimatedCalendar> {
  bool _hovering = false;


@override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width * 0.8;
  final height = MediaQuery.of(context).size.height;

  return Center(
    child: Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: Stack(
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.9,
                child: CalendarControllerProvider<Event>(
                  controller: EventController<Event>(),
                  child: EventsCalendar(),
                ),
              ),
            ),

            if (_hovering)
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pushReplacementNamed(context, events),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "Click Me For More Detail",
                          style: StandardText.copyWith(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

}


