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

const double roundedCorners = 12.0;

TextStyle heading3 = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  fontFamily: "Inter",
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle heading3Selected = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  fontFamily: "Inter",
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle homePageButtons = TextStyle(
  color: Colors.white, 
  fontSize: Dimensions.screenHeight * 0.018
);

double get topLogoSize => Dimensions.screenHeight * 0.12;
double get navIconSize => Dimensions.screenHeight * 0.05;
double get navLabelSize => Dimensions.screenHeight * 0.011;
double get homePageIconSize => Dimensions.screenHeight * 0.03;
\
TextStyle get appName => TextStyle(
  color: MARYLAND_RED,
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.screenHeight * 0.04,
);

String sheetsURLStart = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT8hJUe6LggwRwmGd1Q2AjzIHGhFmi7OlFHrIEsQAq2RwEZOdOceIhv9mX1ek3fTiY8AnbOccXvswsi/pub?gid=";
String sheetsURLEnd = "&single=true&output=csv";