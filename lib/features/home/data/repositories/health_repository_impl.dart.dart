import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/data/models/health_model.dart';
import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';
import 'package:all_for_health/features/home/data/datasources/health_local_data_source.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource _localDataSource;

  HealthRepositoryImpl(this._localDataSource);

  @override
  Future<List<HealthEntity>> getHealthList(String langCode) async {
    final data = await _localDataSource.getHealthList();
    return data
        .map(
          (item) =>
              HealthModel.fromJson(item as Map<String, dynamic>, langCode),
        )
        .toList();
  }

  @override
  Future<HealthEntity?> getHealthDetail(String id, String langCode) async {
    final list = await getHealthList(langCode);
    try {
      return list.firstWhere((element) => element.id == id);
    } catch (_) {
      null;
    }
  }

  @override
  Future<List<HealthEntity>> getHealthListByCategory(
    String categoryTitle,
    String langCode,
  ) async {
    final listTitle = await getHealthList(langCode);
    return listTitle
        .where((element) => element.title == categoryTitle)
        .toList();
  }
}
