import 'dart:io';

import 'package:flutter/material.dart';
import '../data/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool url;
  final String type;

  const ContactRow({super.key, required this.icon, required this.text, required this.url, required this.type});

  Future<void> _launchURL(String url) async
  {
    if (type == "phone")
    {
      final Uri uri = Uri
      (
        scheme: 'tel',
        path: url,
      );
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication))
      {
        throw 'Could not launch $url';
      }
    }
    else if (type == "email")
    {
      final Uri uri = Uri
      (
        scheme: 'mailto',
        path: url,
      );
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication))
      {
        throw 'Could not launch $url';
      }
    }
    else if (type == "website" || type == "social")
    {
      final String clean = url
          .replaceFirst("https://", "")
          .replaceFirst("http://", "");

      final parts = clean.split("/");

      final uri = Uri
      (
        scheme: 'https',
        host: parts.first,        // domain (instagram.com)
        path: parts.length > 1    // path (md_sbe)
            ? parts.sublist(1).join("/")
            : null,
      );
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication))
      {
        throw 'Could not launch $url';
      }
    }
    else if (type == "address")
    {
      final query = Uri.encodeComponent(url);
      final Uri appleUrl = Uri.parse("http://maps.apple.com/?q=$query");
      final Uri googleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");

      try
      {
        if (Platform.isIOS)
        {
          await launchUrl(appleUrl, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
        }
      }
      catch (e)
      {
        debugPrint("Error opening maps: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.screenHeight * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: MARYLAND_RED, size: 25),
          SizedBox(width: Dimensions.screenWidth * 0.05),
          Expanded(
            child: url 
            ? GestureDetector(
                    onTap: () => _launchURL(text.trim()),
                    child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                        ),
                      ),
                  )
            :  Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            )
          ),
        ],
      ),
    );
  }
}
