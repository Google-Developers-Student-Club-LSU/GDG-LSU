//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// Author: Dina Taing
//

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (isDark ? Colors.white : Colors.black).withOpacity(0.1),
              Colors.transparent
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: gBlue.withOpacity(0.6), width: 1.5),
              ),
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        FooterSectionTitle("About Us"),
        FooterText(
          "Since 2019, we’ve hosted workshops on Android development, Google Cloud, and programming, while collaborating with local businesses and industry professionals. Today, we continue to provide a welcoming space for students to build practical skills, connect with peers, and explore their passion for technology.",
        ),
        SizedBox(height: 20),
        FooterSectionTitle("Contact Us"),
        FooterText("teamdsc.lsu@gmail.com"),
        FooterText("3304 S Quad Dr, Baton Rouge, LA 70803"),
        SizedBox(height: 20),
        Center(
          child: SelectableText(
            '© 2025 GDG LSU. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('logo/GDSC.png', width: 100),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FooterSectionTitle("About Us"),
                  FooterText(
                    "Since 2019, we’ve hosted workshops on Android development, Google Cloud, and programming, while collaborating with local businesses and industry professionals. Today, we continue to provide a welcoming space for students to build practical skills, connect with peers, and explore their passion for technology.",
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FooterSectionTitle("Contact Us"),
                  FooterText("teamdsc.lsu@gmail.com"),
                  FooterText("3304 S Quad Dr, Baton Rouge, LA 70803"),
                ],
              ),
            ),
          ],
        ),
        const Center(
          child: SelectableText(
            '© 2025 GDG LSU. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class FooterSectionTitle extends StatelessWidget {
  final String text;
  const FooterSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
          ),
    );
  }
}

class FooterText extends StatelessWidget {
  final String text;
  const FooterText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.85),
        ),
      ),
    );
  }
}
