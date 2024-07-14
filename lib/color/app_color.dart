import 'package:flutter/material.dart';

class AppColor {
  static Color white = Colors.white;
  static Color black = Colors.black38;
  static Color overlay = const Color(0xAA333639);
  static Color primary = const Color(0xFF4CAF50);
  static Color darkPrimary = Color.fromARGB(
    primary.alpha,
    (primary.red * 0.7).round(),
    (primary.green * 0.7).round(),
    (primary.blue * 0.7).round(),
  );
  static Color soilBrown = const Color(0xFF795548);
  static Color soilBeige = const Color(0xFFD7CCC8);
  static Color skyBlue = const Color(0xFF2196F3);
  static Color lightBlue = const Color(0xFF64B5F6);
  static Color harvestYellow = const Color(0xFFFFC107);
  static Color orange = const Color(0xFFFF9800);
  static Color gray = const Color(0xFF9E9E9E);
  static Color lightGray = const Color(0xFFE0E0E0);
}
