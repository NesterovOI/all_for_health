import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/features/home/data/datasources/health_local_data_source.dart';
import 'package:all_for_health/features/home/data/repositories/health_repository_impl.dart.dart';
import 'package:all_for_health/features/home/domain/entities/health_entity.dart';
import 'package:all_for_health/features/home/domain/usecases/export_usecase.dart';

final languageProvider = Provider<String>((ref) => 'uk');

final healthLocalDataSourceProvider = Provider<HealthLocalDataSource>((ref) {
  return HealthLocalDataSource();
});

final healthRepositoryImplProvider = Provider<HealthRepositoryImpl>((ref) {
  final dataSource = ref.watch(healthLocalDataSourceProvider);
  return HealthRepositoryImpl(dataSource);
});

final getHealthByCategoryUseCase = Provider<GetHealthByCategoryUseCase>((ref) {
  final repository = ref.watch(healthRepositoryImplProvider);
  return GetHealthByCategoryUseCase(repository);
});

final getHealthDetailUseCaseProvider = Provider<GetHealthDetailUseCase>((ref) {
  final repository = ref.watch(healthRepositoryImplProvider);
  return GetHealthDetailUseCase(repository);
});

final getHealthListUseCaseProvider = Provider<GetHealthListUseCase>((ref) {
  final repository = ref.watch(healthRepositoryImplProvider);
  return GetHealthListUseCase(repository);
});

final healthListByCategoryProvider =
    FutureProvider.family<List<HealthEntity>, String>((
      ref,
      categoryTitle,
    ) async {
      final langCode = ref.watch(languageProvider);
      final useCase = ref.watch(getHealthByCategoryUseCase);
      return await useCase.call(categoryTitle, langCode);
    });

final healthListProvider = FutureProvider<List<HealthEntity>>((ref) async {
  final langCode = ref.watch(
    languageProvider,
  ); // Якщо мова зміниться, провайдер перезапуститься сам!
  final useCase = ref.watch(getHealthListUseCaseProvider);
  return await useCase.call(langCode);
});

final searchHealthProvider = FutureProvider.family<List<HealthEntity>, String>((
  ref,
  rawQuery,
) async {
  final query = rawQuery.trim().toLowerCase();
  if (query.isEmpty) return const [];
  final allItems = await ref.watch(healthListProvider.future);
  return allItems.where((item) {
    final nameMatch = item.name.toLowerCase().contains(query);
    final descriptionMatch = item.description.toLowerCase().contains(query);
    final categoryIdMatch = item.categoryId.toLowerCase().contains(query);
    return nameMatch || descriptionMatch || categoryIdMatch;
  }).toList();
});
