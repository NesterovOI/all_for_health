import 'package:all_for_health/features/home/domain/repositories/health_repository.dart';
import 'package:all_for_health/features/home/domain/entities/health_entity.dart';

class GetHealthListUseCase {
  final HealthRepository _repository;

  GetHealthListUseCase(this._repository);

  Future<List<HealthEntity>> call(String langCode) async {
    return _repository.getHealthList(langCode);
  }
}
