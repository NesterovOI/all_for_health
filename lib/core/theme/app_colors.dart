import 'package:flutter/material.dart';

abstract class AppColors {
  //Світлі кольори
  static const Color lightBackground = Color(0xE1D4C2);
  static const Color lightSurface = Color(0x6E473B); //Для Card
  static const Color lightSurfaceSecondary = Color(0xA78D78); //Для Card
  static const Color lightTextPrimary = Color(0x291C0E); //Колір тексту name
  static const Color lightTextSecondary = Color(
    0xBEB5A9,
  ); //Колір тексту2 description

  //Темні кольори
  static const Color darkBackground = Color(0x0B2A44);
  static const Color darkSurface = Color(0x4D5365); //Для Card
  static const Color darkSurfaceSecondary = Color(0x167196); //Для Card
  static const Color darkTextPrimary = Color(0xE4EDF5); //Колір тексту name
  static const Color darkTextSecondary = Color(
    0x6C8AA4,
  ); //Колір тексту description

  static const Color primary = Color(0xD08E6F); //background button
  static const Color success = Color(0xCB9A7D); //border button
  static const Color error = Color(0xFFEF4444);
}
