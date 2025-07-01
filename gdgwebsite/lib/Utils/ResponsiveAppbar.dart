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
    final bool mobile = isMobile(context);
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withOpacity(0.95),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushReplacementNamed('/'),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Image.asset(
                        'logo/GDSC.png',
                        height: 36,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        mobile ? 'GDG @ LSU' : 'Google Developer Group @ LSU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                  
                          fontSize: 25,
                          letterSpacing: 0.3,
                         
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: mobile
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: IconButton(
                        icon: const Icon(Icons.menu, size: 28),
                        onPressed: onMenuTap,
                        tooltip: 'Menu',
                        splashRadius: 24,
                      ),
                    ),
                  ]
                : navItems,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
