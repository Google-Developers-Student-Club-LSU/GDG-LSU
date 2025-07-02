//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/EventsData.dart';
import 'package:gdgwebsite/Pages/Eboard.dart';
import 'package:gdgwebsite/Pages/Events.dart';
import 'package:gdgwebsite/Pages/Home.dart';
import 'package:gdgwebsite/Pages/Sponsor.dart';
import 'package:gdgwebsite/Utils/CacheEvents.dart';
import 'package:provider/provider.dart';void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = EventProvider();
        provider.loadEvents(myEvents);
        return provider;
      },
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG@LSU',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
      routes: {
        home: (_) => const HomePage(),
        eboard: (_) => const EboardPage(),
        events: (_) => const EventsPage(),
        sponsor: (_) => const SponsorPage(),
       // '/blog': (_) => const BlogPage()
      }
    );
  }
}


