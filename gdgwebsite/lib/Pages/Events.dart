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
  @override
  Widget build(BuildContext context) {
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
               children: [
                 SizedBox(height: 50,),
                 Center(
                        child: CalendarControllerProvider<Event>(
                          controller: EventController<Event>(),
                          child: WeekCalendar(),
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
}