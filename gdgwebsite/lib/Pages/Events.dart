//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/EventsWidgets/MonthCalendar.dart';
import 'package:gdgwebsite/EventsWidgets/WeekCalendar.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/RandomArts/FlowingWaves.dart';
import 'package:gdgwebsite/RandomArts/GlowingParticles.dart';
import 'package:gdgwebsite/RandomArts/TriangleMesh.dart';
import 'package:gdgwebsite/RandomArts/PerlinFlowField.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  
  bool isWeekView = false;
  @override
  Widget build(BuildContext context) {

    final isLightMode = Theme.of(context).brightness == Brightness.light;
    Color themeBackGround = isLightMode ? Colors.black.withValues(alpha: .2) : Colors.white70.withValues(alpha: .1);
    return Scaffold(
      appBar: const Appbar(),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: PerlinFlowField(),
          ),
           SingleChildScrollView(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                SizedBox(height: 50,),
                PillShapeButton(themeBackGround),
                SizedBox(height: 10,),
                 Center(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
                          child: CalendarControllerProvider<Event>(
                            controller: EventController<Event>(),
                            child: isWeekView ? WeekCalendar(): MonthCalendar(),
                          ),
                        ),
                    
                    ),
                SizedBox(height: 100,),
                FooterBar()
               ],
             ),
           ),

        ],
      )
    );;
  }

  Center PillShapeButton(Color themeBackGround) {
    return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeBackGround,
                        border: Border.all(color: gYellow),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // ⬅️ keeps width tight
                        children: [
                          // Month Button
                          TextButton(
                            onPressed: () => setState(() => isWeekView = false),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              backgroundColor: !isWeekView ? gYellow :themeBackGround,
                              foregroundColor: !isWeekView ? Colors.white :gYellow,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: Size.zero,
                            ),
                            child: const Text("Month", style: TextStyle(fontSize: 12)),
                          ),

                          // Week Button
                          TextButton(
                            onPressed: () => setState(() => isWeekView = true),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              backgroundColor: isWeekView ? gYellow :themeBackGround,
                              foregroundColor: isWeekView ? Colors.white :gYellow,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: Size.zero,
                            ),
                            child: const Text("Week", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}