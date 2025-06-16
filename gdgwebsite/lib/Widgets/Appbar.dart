import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Utils/ResponsiveAppbar.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(title: Text('Home')),
          ListTile(title: Text('Eboard')),
          ListTile(title: Text('Events')),
          ListTile(title: Text('Sponsor')),
        ],
      ),
    );
  }

VoidCallback navButton(BuildContext context, String route) {
  return () => Navigator.pushReplacementNamed(context, route);
}

  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;
    Widget Spacer = SizedBox(width: 25) ;

    return ResponsiveAppBar(
      navItems: [
        _navItem(context, 'Home', '/', textColor),
         Spacer,
        _navItem(context, 'Eboard', '/eboard', textColor),
        Spacer,
        _navItem(context, 'Events', '/events', textColor),
         Spacer,
        _navItem(context, 'Sponsor', '/sponsor', textColor),
        Spacer,
      ],
      onMenuTap: () => _openMobileMenu(context),
    );
  }

  Widget _navItem(BuildContext context, String label, String route, Color? color) {
    return TextButton(
      onPressed: navButton(context, route),
      child: Text(
        label,
        style: GoogleFonts.ptSans(
          fontWeight: FontWeight.w200,
          fontSize: 20,
          color: color,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
