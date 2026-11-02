import 'package:flutter/material.dart';

class CategoryEntity {
  final String id;
  final String name;
  final int colorValue;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.colorValue,
  });

  Color get color => Color(colorValue);
}
