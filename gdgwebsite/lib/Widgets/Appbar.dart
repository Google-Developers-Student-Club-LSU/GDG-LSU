import 'package:flutter/material.dart';
import 'package:gdgwebsite/Utils/ResponsiveAppbar.dart';

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
    return () => Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAppBar(
      navItems: [
        TextButton(onPressed: navButton(context, '/home'), child: const Text('Home')),
        TextButton(onPressed: navButton(context, '/eboard'), child: const Text('Eboard')),
        TextButton(onPressed: navButton(context, '/events'), child: const Text('Events')),
        TextButton(onPressed: navButton(context, '/sponsor'), child: const Text('Sponsor')),
      ],
      onMenuTap: () => _openMobileMenu(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
