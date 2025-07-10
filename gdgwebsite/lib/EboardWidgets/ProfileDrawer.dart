import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: lightBackgroundColor,
        border: Border.all(
          color: gBlue, // Change to any border color you prefer
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  fullName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: lightLetterColor,
                      ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  position,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: lightLetterColor,
                      ),
                ),
                const SizedBox(height: 12),
                SelectableText(
                  yearAndMajor,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 17,
                        color: lightLetterColor,
                      ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 250,
                  child: SingleChildScrollView(
                      child:  SelectableText(
                        shortIntroduction,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 15, color: lightLetterColor),

                      ),
                    
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
              width: 70,
              imageAsset: linkedInLogo,
              linkUrl: linkedinLink,
            ),
          ),
        ],
      ),
    );
  }
}
