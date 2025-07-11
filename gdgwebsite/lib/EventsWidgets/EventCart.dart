//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/EventsWidgets/CreateEvent.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:intl/intl.dart';

class EventCart extends StatelessWidget {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final Color color; 
  final String? image;
  final String? room; 
  final String? gallerUrl;
  final VoidCallback? onClose;

  const EventCart({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    required this.color,
    this.room,
    this.gallerUrl,
    this.image = failedImage,
    required this.description,


    this.onClose,
  });

  @override
Widget build(BuildContext context) {

   bool timeNotAvailable = 
    start == end || end.difference(start).inMinutes <= 30;;
   
   final isLightMode = Theme.of(context).brightness == Brightness.light;
   final greyColor = isLightMode ? Colors.black54 : Colors.white70;
  final isMobile = MediaQuery.of(context).size.width < 900;

  return Center(
    child: Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(16), 
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * (isMobile ? 0.8 :0.6),
        constraints: const BoxConstraints(
          maxHeight: 600, 
        ),
        padding: const EdgeInsets.all(20),
        decoration:  BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: color, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                 Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(gDSCLogo, height: 32,) ,
                  ),
                 Spacer(),
                 Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),

              const SizedBox(height: 10),

              SelectableText(
                'Events: $title',
                style: StandardText.copyWith(fontSize: isMobile ? 30 : 40),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),

                SelectableText(
                  timeNotAvailable ?
                  'Time will be announced soon'
                   : 'Time: ${DateFormat('h:mm a').format(start)} — ${DateFormat('h:mm a').format(end)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color:timeNotAvailable ? gRed : color, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SelectableText(
                  room == null ?
                  'Room: TBD'
                   : 'Room: $room',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: room == null? gRed : greyColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 12),

              Container(
                width:  MediaQuery.of(context).size.width * 0.4,
                child: SelectableText(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
                  textAlign: TextAlign.left,
                
                ),
              ),
              const SizedBox(height: 12),

              Image.asset(
                image ?? failedImage ,
                width: MediaQuery.of(context).size.width * 0.4,
                fit: BoxFit.contain,
                 errorBuilder: (context, error, stackTrace) {
                  return const Text("Image failed to load.");
                },
              ),
              const SizedBox(height: 50),
              CalendarButton(title: title, description: description, start: start, end: end, room: room,color: color,),
                  if (gallerUrl != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10 ,left: 10, bottom: 10),
                              child: Row(
                                children: [
                                  ClickableImageLink(
                                    width: 70,
                                    imageAsset: iconGallery,
                                    linkUrl: gallerUrl ?? '/',
                                  ),
                                const SizedBox(height: 10),
                                SelectableText('⬅️ Tap to see the event gallery', 
                                style: StandardText.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                                )

                                ],
                              ),
                            ),
                          ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
