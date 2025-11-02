import 'package:flutter/material.dart';
import '../data/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool url;

  const ContactRow({super.key, required this.icon, required this.text, required this.url});

  Future<void> _launchURL(String url) async
{
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
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
                    onTap: () => _launchURL("https://" + text.trim()),
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
