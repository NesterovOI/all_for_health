import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:all_for_health/core/theme/app_strings.dart';

class HealthLocalDataSource {
  Future<List<dynamic>> getHealthList() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/json/health_data.json',
      );
      final List<dynamic> data = json.decode(response);
      return data;
    } catch (e) {
      throw Exception(AppStrings.errorLoadingHealthList + e.toString());
    }
  }
}
