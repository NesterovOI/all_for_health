import 'package:all_for_health/features/home/domain/entities/health_entity.dart';

abstract class HealthRepository {
  Future<List<HealthEntity>> getHealthList(String langCode);
  Future<HealthEntity?> getHealthDetail(String id, String langCode);
}
