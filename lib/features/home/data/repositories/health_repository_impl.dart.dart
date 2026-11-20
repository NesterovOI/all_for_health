import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/data/models/health_model.dart';
import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';
import 'package:all_for_health/features/home/data/datasources/health_local_data_source.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource _localDataSource;

  HealthRepositoryImpl(this._localDataSource);

  @override
  Future<List<HealthEntity>> getHealthListByCategory(
    String categoryId,
    String langCode,
  ) async {
    final rawItems = await _localDataSource.getHealthList(categoryId);

    return rawItems
        .map(
          (item) =>
              HealthModel.fromJson(item as Map<String, dynamic>, langCode),
        )
        .toList();
  }

  @override
  Future<List<HealthEntity>> getHealthList(String langCode) async {
    // Завантажуємо всі категорії паралельно, якщо знадобиться загальний список
    final categories = [
      'herbs',
      'recipes',
      'diseases',
      'microelements',
      'products',
      'cooking',
    ];
    final results = await Future.wait(
      categories.map((cat) => getHealthListByCategory(cat, langCode)),
    );
    return results.expand((list) => list).toList();
  }

  @override
  Future<HealthEntity?> getHealthDetail(String id, String langCode) async {
    final allItems = await getHealthList(langCode);
    try {
      return allItems.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
