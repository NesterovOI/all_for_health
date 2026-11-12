import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class WatchNotesUseCase {
  final CatalogRepository _repository;
  WatchNotesUseCase(this._repository);

  Stream<List<NoteEntity>> call({String? categoryId}) =>
      _repository.watchNote(categoryId: categoryId);
}
