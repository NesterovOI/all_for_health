import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:all_for_health/core/theme/app_strings.dart';

List<dynamic> _parseJsonList(String encoded) {
  return json.decode(encoded) as List<dynamic>;
}

class HealthLocalDataSource {
  final Map<String, List<dynamic>> _cacheByCategory = {};

  static const Set<String> _knownCategories = {
    'herbs',
    'recipes',
    'diseases',
    'microelements',
    'products',
    'cooking',
  };

  String _assetPathForCategory(String categoryId) {
    final normalized = categoryId.trim().toLowerCase();
    if (_knownCategories.contains(normalized)) {
      return 'assets/data/json/$normalized.json';
    }
    throw ArgumentError(AppStrings.unknownCategoryId + categoryId);
  }

  Future<List<dynamic>> getHealthList(String categoryId) async {
    final cached = _cacheByCategory[categoryId];
    if (cached != null) {
      return cached;
    }

    try {
      final path = _assetPathForCategory(categoryId);
      final String response = await rootBundle.loadString(path);

      final List<dynamic> decoded = await compute(_parseJsonList, response);
      _cacheByCategory[categoryId] = decoded;
      return decoded;
    } catch (e) {
      throw Exception('${AppStrings.errorLoadingHealthList}$e');
    }
  }

  Future<void> preloadCategories(List<String> categoryIds) async {
    for (final id in categoryIds) {
      if (!_cacheByCategory.containsKey(id)) {
        try {
          await getHealthList(id);
        } catch (_) {}
      }
    }
  }
}
