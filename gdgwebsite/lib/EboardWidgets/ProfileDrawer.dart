import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';

class ProfileDrawer extends StatelessWidget {
  final String fullName;
  final String position;
  final String yearAndMajor;
  final String shortIntroduction;
  final String linkedinLink;

  const ProfileDrawer({
    super.key,
    required this.fullName,
    required this.position,
    required this.yearAndMajor,
    required this.shortIntroduction,
    required this.linkedinLink,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: lightLetterColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  position,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: lightLetterColor,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  yearAndMajor,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 17,
                        color: lightLetterColor,
                      ),
                  softWrap: true,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: Text(
                    shortIntroduction,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15, color: lightLetterColor),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),

          // Bottom-left LinkedIn icon
          Positioned(
            left: 20,
            bottom: 20,
            child: ClickableImageLink(
              width: 100,
              imageAsset: 'logo/LinkedIn.png',
              linkUrl: linkedinLink,
            ),
          ),
        ],
      ),
    );
  }
}
