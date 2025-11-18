import 'package:flutter/material.dart';
import '../data/constants.dart';

class ScreenHeader extends StatelessWidget {
  final String logoPath;
  final String countyName;
  final String title;

  const ScreenHeader({
    super.key,
    required this.logoPath,
    required this.countyName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = Dimensions.screenHeight;
    final screenWidth =  Dimensions.screenWidth;

    return Column(
      children: [
        Center(
          child: Image.asset(
            logoPath,
            height: topLogoSize,
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(height: screenHeight * 0.006),
        Center(child: Text("Jared DeMarinis, State Administrator", style: smallDetails)),

        // SizedBox(
        //   height: screenHeight * 0.05,
        //   child: ElevatedButton.icon(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: MARYLAND_RED,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(roundedCorners)),
        //       padding: EdgeInsets.symmetric(
        //         horizontal: screenWidth * 0.05,
        //         vertical: 0,
        //       ),
        //     ),
        //     onPressed: () {},
        //     icon: const Icon(Icons.pin_drop, color: Colors.white, size: 20),
        //     label: Text(
        //       countyName.toUpperCase(),
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: screenWidth * 0.04,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),

        SizedBox(height: screenHeight * 0.006),

        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}
