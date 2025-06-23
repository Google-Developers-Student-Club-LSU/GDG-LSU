import 'package:flutter/material.dart';
import 'package:gdgwebsite/Utils/HoverExpand.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _launchLink() async {
    final Uri url = Uri.parse(linkUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $linkUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchLink,
      child: HoverExpand(
        child: Image.asset(imageAsset, width: width),
      ),
    );
  }
}
