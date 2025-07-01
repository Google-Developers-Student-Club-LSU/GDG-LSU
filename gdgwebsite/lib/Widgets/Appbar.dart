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
 static OverlayEntry? _menuOverlay;
 void _showTopDropdown(BuildContext context) {
  if (_menuOverlay != null) {
    _menuOverlay!.remove();
    _menuOverlay = null;
    return;
  }

  final overlay = Overlay.of(context);

  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  late Animation<double> opacityAnimation;

  _menuOverlay = OverlayEntry(
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          controller = AnimationController(
            vsync: Navigator.of(context),
            duration: const Duration(milliseconds: 200),
          );
          offsetAnimation = Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
          opacityAnimation = CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          );

          controller.forward();

          return GestureDetector(
            onTap: () {
              controller.reverse().then((_) {
                _menuOverlay?.remove();
                _menuOverlay = null;
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: Colors.transparent),
                  ),
                  Positioned(
                    top: kToolbarHeight,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: opacityAnimation,
                        child: Material(
                          elevation: 4,
                          color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _dropdownItem(context, 'Home', home),
                              _dropdownItem(context, 'Eboard', eboard),
                              _dropdownItem(context, 'Events', events),
                              _dropdownItem(context, 'Sponsor', sponsor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  overlay.insert(_menuOverlay!);
}

Widget _dropdownItem(BuildContext context, String label, String route) {
  return ListTile(
    title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
    onTap: () {
      _menuOverlay?.remove();
      _menuOverlay = null;
      Navigator.pushReplacementNamed(context, route);
    },
  );
}


  // PopupMenuItem _popupItem(BuildContext context, String label, String route, ThemeData theme) {
  //   return PopupMenuItem(
  //     textStyle: GoogleFonts.ptSans(
  //       color: theme.textTheme.bodyMedium?.color,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     child: Text(label),
  //     onTap: () => Future.delayed(Duration.zero, () {
  //       Navigator.pushReplacementNamed(context, route);
  //     }),
  //   );
  // }

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