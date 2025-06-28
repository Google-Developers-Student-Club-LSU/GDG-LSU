// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Author: Dina Taing

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: gBlue, width: 1)
        ),
      color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: double.infinity,
      
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
                const SizedBox(height: 20),
                Center(
                  child: SelectableText(
                    '© 2025 GDG LSU. All rights reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            )
          : Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('logo/GDSC.png', width: 100,),
                    ),
                    SizedBox(width: 30,),
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
            Center(
                  child: SelectableText(
                    '© 2025 GDG LSU. All rights reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
      child: SelectableText(
        text,
        style: const TextStyle( fontSize: 14),
      ),
    );
  }
}
