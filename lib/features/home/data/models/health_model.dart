import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/core/theme/app_strings.dart';

class HealthModel extends HealthEntity {
  HealthModel({
    required super.id,
    required super.categoryId,
    required super.title,
    required super.name,
    required super.description,
    required super.health,
    super.youTube,
    super.image,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json, String langCode) {
    final translations = json['translations'] as Map<String, dynamic>? ?? {};
    final currentTranslations =
        translations[langCode] as Map<String, dynamic>? ??
        translations['en'] as Map<String, dynamic>? ??
        {};
    return HealthModel(
      id: json['id'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      name: currentTranslations['name'] as String? ?? AppStrings.noName,
      description:
          currentTranslations['description'] as String? ??
          AppStrings.noDescription,
      health: currentTranslations['health'] as String? ?? '',
      youTube: currentTranslations['youTube'] as String?,
      image: json['image'] as String?,
    );
  }
}
