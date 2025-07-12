//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/EboardWidgets/DrawerAnimation.dart';
import 'package:gdgwebsite/MembersData.dart';
import 'package:gdgwebsite/RandomArts/FlowingWaves.dart';
import 'package:gdgwebsite/RandomArts/GlowingParticles.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';

class EboardPage extends StatefulWidget {
  const EboardPage({super.key});

  @override
  State<EboardPage> createState() => _EboardPageState();
}

class _EboardPageState extends State<EboardPage> with TickerProviderStateMixin {
  bool showIntro = true;
  final String introText = 'Tap a board member to see who they are.';
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);

    // Automatically fade out the intro after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1200), () {
      _fadeController.forward().then((_) {
        setState(() {
          showIntro = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double containerWidth = 300;
    const double containerHeight = 500;

    return Scaffold(
      appBar: const Appbar(borderColor: gRed),
      body: Stack(
        children: [
          if (isMobile(context) && showIntro)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: FlowingWaves() ,
                      ),
                      Center(
                        child: Text(
                          introText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                    
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (!showIntro || !isMobile(context))
            Positioned.fill(child: GlowingParticles()),

          if (!showIntro || !isMobile(context))
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
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
                          ),
                          const Spacer(),
                          const FooterBar(footbarColor: gRed),
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
