import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Utils/HoverButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CalendarButton extends StatelessWidget {
  final String title; 
  final String description;
  final DateTime start;
  final DateTime end;
  final Color color;
  final String? room; 


  const CalendarButton({super.key, 
  required this.title,
  required this.description,
  required this.start,
  required this.end,
  required this.color,
  this.room = ''});

  void _createEvent() async {
  final encodedTitle = Uri.encodeComponent(title);
  final encodedDetails = Uri.encodeComponent(description);
  final encodedLocation = Uri.encodeComponent(room ?? '');

  final startUtc = start.toUtc();
  final endUtc = end.toUtc();

  final format = DateFormat("yyyyMMdd'T'HHmmss'Z'");
  final startStr = format.format(startUtc);
  final endStr = format.format(endUtc);

  final url = Uri.parse(
    'https://calendar.google.com/calendar/render?action=TEMPLATE'
    '&text=$encodedTitle'
    '&details=$encodedDetails'
    '&location=$encodedLocation'
    '&dates=$startStr/$endStr',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch calendar';
  }
}


  @override
  Widget build(BuildContext context) {
    return HoverButton(
      child: Container(
        width: 200,
        height: 50,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: color,
          border: Border.all(color: Colors.black)
        ),
        child: Center(
          child: Text("Add to Calendar",
          style:  StandardText.copyWith(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
     onTap: () => _createEvent(),

     );
  }
}
