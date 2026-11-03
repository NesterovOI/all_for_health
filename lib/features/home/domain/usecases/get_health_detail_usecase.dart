import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';

class GetHealthDetailUseCase {
  final HealthRepository _repository;

  GetHealthDetailUseCase(this._repository);

  Future<HealthEntity?> call(String id, String langCode) async {
    return await _repository.getHealthDetail(id, langCode);
  }
}
