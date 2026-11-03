import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';

class GetHealthByCategoryUseCase {
  final HealthRepository _repository;

  GetHealthByCategoryUseCase(this._repository);
  Future<List<HealthEntity>> call(String categoryTitle, String langCode) async {
    return await _repository.getHealthListByCategory(categoryTitle, langCode);
  }
}
