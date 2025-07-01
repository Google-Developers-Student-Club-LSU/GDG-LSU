//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/EboardWidgets/DrawerAnimation.dart';
import 'package:gdgwebsite/RandomArts/GlowingParticles.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';

class EboardPage extends StatefulWidget {
  const EboardPage({super.key});

  @override
  State<EboardPage> createState() => _EboardPageState();
}

class _EboardPageState extends State<EboardPage> {
 @override
Widget build(BuildContext context) {
  const double containerWidth = 300;
  const double containerHeight = 500;

  return Scaffold(
    appBar: const Appbar(),
    body: Stack(
  children: [
    Positioned.fill(child: GlowingParticles()),

    LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Main content
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 40,
                      runSpacing: 40,
                      children: members.map((member) {
                        return SizedBox(
                          width: containerWidth,
                          height: containerHeight,
                          child: AnimationPage(
                            fullName: member.fullName,
                            position: member.position,
                            yearAndMajor: member.yearAndMajor,
                            shortIntroduction: member.shortIntro,
                            linkedinLink: member.linkedin,
                            assets: member.imageAsset,
                            width: containerWidth,
                            height: containerHeight,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const Spacer(), // Pushes footer down if space available

                  const FooterBar(),
                ],
              ),
            ),
          ),
        );
      },
    ),
  ],
),

  );
}
}
