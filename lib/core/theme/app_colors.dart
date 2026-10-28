import 'package:flutter/material.dart';

abstract class AppColors {
  //Світлі кольори
  static const Color lightBackground = Color(0xFFE1D4C2);
  static const Color lightSurface = Color(0xFF6E473B); //Для Card
  static const Color lightSurfaceSecondary = Color(0xFFA78D78); //Для Card
  static const Color lightTextPrimary = Color(0xFF291C0E); //Колір тексту name
  static const Color lightTextSecondary = Color(
    0xFFBEB5A9,
  ); //Колір тексту2 description

  //Темні кольори
  static const Color darkBackground = Color(0xFF0B2A44);
  static const Color darkSurface = Color(0xFF4D5365); //Для Card
  static const Color darkSurfaceSecondary = Color(0xFF167196); //Для Card
  static const Color darkTextPrimary = Color(0xFFE4EDF5); //Колір тексту name
  static const Color darkTextSecondary = Color(
    0xFF6C8AA4,
  ); //Колір тексту description

  static const Color primary = Color(0xFFD08E6F); //background button
  static const Color success = Color(0xFFCB9A7D); //border button
  static const Color error = Color(0xFFEF4444);
}
