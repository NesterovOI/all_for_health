import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class ManageCatalogUseCase {
  final CatalogRepository _repository;
  ManageCatalogUseCase(this._repository);

  Future<void> addCatalog(CategoryEntity category) =>
      _repository.insertCategory(category);
  Future<void> addNote(NoteEntity note) => _repository.insertNote(note);
  Future<void> deleteNote(String id) => _repository.deleteNote(id);
  Future<bool> updateNote(NoteEntity note) => _repository.updateNote(note);
  Future<NoteEntity?> getNoteById(String id) => _repository.getNoteById(id);
}
