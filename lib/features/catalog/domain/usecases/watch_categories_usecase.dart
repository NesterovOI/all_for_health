import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class WatchCategoriesUseCase {
  final CatalogRepository _repository;
  WatchCategoriesUseCase(this._repository);

  Stream<List<CategoryEntity>> call() => _repository.watchCategories();
}
