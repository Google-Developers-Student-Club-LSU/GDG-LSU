//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//


import 'package:flutter/material.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> navItems;
  final VoidCallback onMenuTap;

  const ResponsiveAppBar({
    super.key,
    required this.navItems,
    required this.onMenuTap,
  });

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 1000;

  @override
Widget build(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              Image.asset(
                'logo/GDSC.png',
                height: 32,
              ),
              const SizedBox(width: 8),
            Text(
                isMobile(context) ? 'GDG @ LSU': 'Google Developer Group @ LSU',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: isMobile(context)
        ? [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuTap,
            ),
          ]
        : navItems,
  );
}

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
