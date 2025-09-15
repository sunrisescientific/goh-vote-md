import 'package:flutter/material.dart';

class Dimensions {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }
}

const Color MARYLAND_RED = Color(0xFFB60022);
const Color MARYLAND_YELLOW = Color(0xFFFFA100);
const Color UNSELECTED = Color(0x88E5E5E5);

// contacts small header, locations name and tab
TextStyle heading3 = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  fontFamily: "Inter",
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

//locations tab
TextStyle heading3Selected = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  fontFamily: "Inter",
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

//home pages 6 button label
TextStyle homePageButtons = TextStyle(
  color: Colors.white, 
  fontSize: Dimensions.screenHeight * 0.018
);

double get topLogoSize => Dimensions.screenHeight * 0.12;
double get navIconSize => Dimensions.screenHeight * 0.05;
double get navLabelSize => Dimensions.screenHeight * 0.011;
double get homePageIconSize => Dimensions.screenHeight * 0.03;

// home page app name
TextStyle get appName => TextStyle(
  color: MARYLAND_RED,
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.screenHeight * 0.04,
);
