import 'package:flutter/material.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> navItems;
  final VoidCallback onMenuTap;

  const ResponsiveAppBar({
    super.key,
    required this.navItems,
    required this.onMenuTap,
  });

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 800;

  @override
Widget build(BuildContext context) {
  return AppBar(
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
              const Text(
                'Google Developer Group @LSU',
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
