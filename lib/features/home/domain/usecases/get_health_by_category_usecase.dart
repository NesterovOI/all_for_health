import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';

class GetHealthByCategoryUseCase {
  final HealthRepository _repository;

  GetHealthByCategoryUseCase(this._repository);
  Future<List<HealthEntity>> call(String categoryId, String langCode) async {
    return await _repository.getHealthListByCategory(categoryId, langCode);
  }
}
