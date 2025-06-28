//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:intl/intl.dart';

class EventCart extends StatelessWidget {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final String? image;
  final VoidCallback? onClose;

  const EventCart({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    this.image = 'events/NoImage.png',
    required this.description,

    this.onClose,
  });

  @override
Widget build(BuildContext context) {
  return Center(
    child: Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        constraints: const BoxConstraints(
          maxHeight: 600, // limit max height but allow scrolling
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: gYellow),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                'Events: $title',
                style: StandardText,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Text(
                '${DateFormat('h:mm a').format(start)} — ${DateFormat('h:mm a').format(end)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              Image.asset(
                image ?? 'events/NoImage.png' ,
                width: MediaQuery.of(context).size.width * 0.4,
                fit: BoxFit.contain,
                 errorBuilder: (context, error, stackTrace) {
                  return const Text("Image failed to load.");
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
