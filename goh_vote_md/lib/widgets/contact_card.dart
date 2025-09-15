import 'package:flutter/material.dart';
import 'contact_row.dart';
import '../data/constants.dart';

class ContactCard extends StatelessWidget {
  final String title;
  final List<ContactRow> rows;
  final Widget? dropdown;

  const ContactCard({super.key, required this.title, required this.rows, this.dropdown});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Dimensions.screenHeight;
    final screenWidth =  Dimensions.screenWidth;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
      child: SizedBox(
        width: screenWidth * 0.86,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: MARYLAND_YELLOW, width: 3),
            ),
          ),
          onPressed: () {},
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Text(title,
                      style: heading3),
                ),
                if (dropdown != null) dropdown!,
                SizedBox(height: screenHeight * 0.01),
                ...rows,
                SizedBox(height: screenHeight * 0.03)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
