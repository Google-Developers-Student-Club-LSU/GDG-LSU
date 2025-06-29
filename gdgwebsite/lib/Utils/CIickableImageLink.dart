//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Utils/HoverExpand.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ClickableImageLink extends StatelessWidget {
  final String imageAsset;
  final String linkUrl;
  final double width;

  const ClickableImageLink({
    super.key,
    required this.imageAsset,
    required this.linkUrl,
    this.width = 150,
  });

  Future<void> _launchLink() async {
    final Uri url = Uri.parse(linkUrl);

    if (kIsWeb) {
      // For web, open in a new tab without checking canLaunch
      await launchUrl(url, webOnlyWindowName: '_blank');
    } else {
      // For mobile/desktop platforms
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      } else {
        debugPrint('Could not launch $linkUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchLink,
      child: HoverExpand(
        child: Image.asset(imageAsset, width: width),
      ),
    );
  }
}
