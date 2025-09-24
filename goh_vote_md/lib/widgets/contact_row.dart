import 'package:flutter/material.dart';
import '../data/constants.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactRow({super.key, required this.icon, required this.text});

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
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
