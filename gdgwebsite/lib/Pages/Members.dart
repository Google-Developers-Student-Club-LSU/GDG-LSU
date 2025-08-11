import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(borderColor: gPurple),

      body: Scaffold(
        body: Column(
          children: [
            Spacer(),
            FooterBar(footbarColor: gPurple)
          ],
        ),
      ),
    );
  }
}