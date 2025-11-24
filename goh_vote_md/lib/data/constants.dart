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
const Color SELECTED = Color(0xFFFFFFFF);
const Color BACKGROUND = Color(0xFFFFFFFF);

const double roundedCorners = 12.0;

//contacts small header, locations name and tab
TextStyle heading3 = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  // fontFamily: "Inter",
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

//locations tab
TextStyle heading3Selected = TextStyle(
  fontSize: Dimensions.screenHeight * 0.018,
  // fontFamily: "Inter",
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

//directions text, calendar dates
TextStyle smallDetails = TextStyle(
  fontSize: Dimensions.screenHeight * 0.014,
  // fontFamily: "Inter",
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

//upcoming elections text, add to calendar buttons
TextStyle smallDetails2 = TextStyle(
  fontSize: Dimensions.screenHeight * 0.014,
  // fontFamily: "Inter",
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

//directions text, calendar dates
TextStyle smallLinks = TextStyle(
  fontSize: Dimensions.screenHeight * 0.014,
  // fontFamily: "Inter",
  color: Colors.blue,
  fontWeight: FontWeight.w500,
  decoration: TextDecoration.underline,
);

//faqs categories, helpful links buttons
TextStyle heading2 = TextStyle(
  fontSize: Dimensions.screenHeight * 0.023,
  // fontFamily: "Inter",
  color: MARYLAND_RED,
  fontWeight: FontWeight.w600,
  shadows:
  [
    Shadow
    (
      offset: Offset(2, 2),
      blurRadius: 4,
      color: Color.fromARGB(255, 205, 204, 204),
    ),
  ],
);

//faqs boxes, helpful links boxes
BoxShadow greyBoxShadow = BoxShadow(
  color: Color.fromARGB(255, 196, 196, 196),
  spreadRadius: 0.5,
  blurRadius: 2,
  offset: Offset(2.5, 2.5),
);

//locations boxes, calendar events boxes
BoxShadow yellowBoxShadow = BoxShadow(
  color: MARYLAND_YELLOW,
  offset: Offset(4, 4),
  blurRadius: 0,
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
double get expandableBoxSize => Dimensions.screenWidth * 0.9;

// home page app name
TextStyle get appName => TextStyle(
  color: MARYLAND_RED,
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.screenHeight * 0.04,
);

String sheetsURLStart = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT8hJUe6LggwRwmGd1Q2AjzIHGhFmi7OlFHrIEsQAq2RwEZOdOceIhv9mX1ek3fTiY8AnbOccXvswsi/pub?gid=";
String sheetsURLEnd = "&single=true&output=csv";
