// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Author: Dina Taing

import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4285F4), // Blue
            Color(0xFFEA4335), // Red
            Color(0xFFFBBC05), // Yellow
            Color(0xFF34A853), // Green
          ],
          stops: [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      child: isMobile
          ? Column(
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
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
