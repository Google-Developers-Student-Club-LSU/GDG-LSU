import 'package:flutter/material.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';

class HackathonPage extends StatefulWidget {
  const HackathonPage({super.key});

  @override
  State<HackathonPage> createState() => _HackathonPageState();
}

class _HackathonPageState extends State<HackathonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      
    );
  }
}