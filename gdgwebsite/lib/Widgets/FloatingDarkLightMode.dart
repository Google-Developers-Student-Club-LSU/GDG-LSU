import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/provider/ThemeProvider.dart';
import 'package:provider/provider.dart';

class FloatingDarkLightmode extends StatelessWidget {
  final Color backgroundColor; 
  const FloatingDarkLightmode({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return FloatingActionButton(
      autofocus: true,
      enableFeedback: false,
      shape: CircleBorder(),
      backgroundColor: backgroundColor,
      hoverColor: gRed,
      splashColor: gYellow,
      onPressed: themeProvider.toggleTheme,
      tooltip: 'Toggle Dark/Light Mode',
      child: Icon(isDark ? Icons.light_mode : Icons.dark_mode, 
      color: Colors.white),
    );
  }
}
