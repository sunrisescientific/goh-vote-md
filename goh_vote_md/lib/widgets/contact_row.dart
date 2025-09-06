import 'package:flutter/material.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB60022), size: 25),
          SizedBox(width: screenWidth * 0.05),
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
