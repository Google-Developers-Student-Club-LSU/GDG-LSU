//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/EboardWidgets/DrawerAnimation.dart';
import 'package:gdgwebsite/RandomArts/GlowingParticles.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';

class EboardPage extends StatefulWidget {
  const EboardPage({super.key});

  @override
  State<EboardPage> createState() => _EboardPageState();
}

class _EboardPageState extends State<EboardPage> {
  @override
  Widget build(BuildContext context) {
     const double containerWidth= 300;
     const double  containerHeight = 500;
    return Scaffold(
     
      appBar: const Appbar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: GlowingParticles(),
          ), 
          Column(
            children: [
              Trenton(containerWidth: containerWidth, containerHeight: containerHeight),
              Jerrick(containerWidth: containerWidth, containerHeight: containerHeight)
            ],
          )
         
        ],
      ),
    );
  }
}
class Jerrick extends StatelessWidget {
  const Jerrick({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  final double containerWidth;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: AnimationPage(fullName: 'Jerrick Miles', position: 'Treasurer', yearAndMajor: 'Computer Science minor DMAET (Digital Media Arts and Engineering)', shortIntroduction: 'At the heart of everything I do is a simple motto: Build your tomorrow.  My software journey started in middle school, and now as a Computer Science student at LSU, I’m combining software with UX design to create tools that will help people everywhere!', linkedinLink:'http://linkedin.com/in/jerrick-miles', assets: 'members/Jerrick.jpg', width: containerWidth, height: containerHeight)
    );
  }
}

class Trenton extends StatelessWidget {
  const Trenton({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  final double containerWidth;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: AnimationPage(fullName: 'Treton', position: 'Treasaury', yearAndMajor: 'Computer Science Junior', shortIntroduction: 'ffhjksal kjhfdd jlkhgajklhv clfsjdkh gwjklsgf hvuesohfgkjhtoig efshjoitrjhtrgoif ;dvjrtyjir op;gj;tgok hjrew i42jt ipo2bj4pio2[3 rjtep2orwjt vbop32j3p2o4jrt 2pojepo je2poj feopjf peojklef jok;j3fo;i2j;pio23gj; gfjwe]', linkedinLink:'www.google.com', assets: 'members/Trenton.jpg', width: containerWidth, height: containerHeight)
    );
  }
}