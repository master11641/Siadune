import 'package:flutter/material.dart';

class CustomColor {
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Colors.black45;
  static const Color dark_grey = Color(0xFF3A5160);
  static const Color lightGrey = Color.fromRGBO(239, 240, 241, 1);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color primaryColor = Color.fromRGBO(145, 31, 82, 1);
  static const Color primaryYellowColor = Color.fromRGBO(248, 225, 91, 0.9);
  static const LinearGradient primaryGradiant = LinearGradient(
      colors: <Color>[CustomColor.primaryColor, Colors.pinkAccent],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}
