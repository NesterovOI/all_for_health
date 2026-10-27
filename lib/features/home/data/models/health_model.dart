import 'package:all_for_health/features/home/domain/entities/health_entity.dart';

class HealthModel extends HealthEntity {
  HealthModel({
    required super.id,
    required super.title,
    required super.name,
    required super.description,
    required super.health,
    super.youTube,
    super.image,
  });

  factory HealthModel.froJson(Map<dynamic, String> json) {
    return HealthModel(
      id: json['id'] as String,
      title: json['title'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      health: json['health'] as String,
      youTube: json['youTube'] as String,
      image: json['image'] as String,
    );
  }
}
