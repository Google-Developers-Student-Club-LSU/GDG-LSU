//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Utils/NavHoverItem.dart';
import 'package:gdgwebsite/Utils/ResponsiveAppbar.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  VoidCallback navButton(BuildContext context, String route) {
    return () => Navigator.pushReplacementNamed(context, route);
  }

  void _showTopDropdown(BuildContext context) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final theme = Theme.of(context);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 40,
        kToolbarHeight,
        0,
        0,
      ),
      color: theme.appBarTheme.backgroundColor,
      items: [
        _popupItem(context, 'Home', home, theme),
        _popupItem(context, 'Eboard', eboard, theme),
        _popupItem(context, 'Events', events, theme),
        _popupItem(context, 'Sponsor', sponsor, theme),
      ],
    );
  }

  PopupMenuItem _popupItem(BuildContext context, String label, String route, ThemeData theme) {
    return PopupMenuItem(
      textStyle: GoogleFonts.ptSans(
        color: theme.textTheme.bodyMedium?.color,
        fontWeight: FontWeight.w500,
      ),
      child: Text(label),
      onTap: () => Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, route);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;    Widget spacer = const SizedBox(width: 25);

return ResponsiveAppBar(
  navItems: [
    NavHoverItem(
      label: 'Home',
      route: home,
      baseColor: textColor,
      hoverColor: gBlue,
    ),
    spacer,
    NavHoverItem(
      label: 'Eboard',
      route: eboard,
      baseColor: textColor,
      hoverColor: gYellow,
    ),
    spacer,
    NavHoverItem(
      label: 'Events',
      route: events,
      baseColor: textColor,
      hoverColor: gGreen,
    ),
    spacer,
    NavHoverItem(
      label: 'Sponsor',
      route: sponsor,
      baseColor: textColor,
      hoverColor: gRed,
    ),
    spacer,
  ],
  onMenuTap: () => _showTopDropdown(context),
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