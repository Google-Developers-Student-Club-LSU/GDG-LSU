import 'package:flutter/material.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> navItems;
  final VoidCallback onMenuTap;
  final bool isMenuOpen;
  final Animation<double> menuAnimation;

  const ResponsiveAppBar({
    super.key,
    required this.navItems,
    required this.onMenuTap,
    required this.isMenuOpen,
    required this.menuAnimation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 1000;

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobile(context);
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor.withOpacity(.95),
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
                      style: const TextStyle(
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
                      onPressed: onMenuTap,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: menuAnimation,
                        size: 28,
                      ),
                      splashRadius: 24,
                      tooltip: isMenuOpen ? 'Close Menu' : 'Open Menu',
                    ),
                  ),
                ]
              : navItems,
        ),
      ),
    );
  }
}
