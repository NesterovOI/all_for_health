import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';

abstract class CatalogRepository {
  Stream<List<CategoryEntity>> watchCategories();
  Stream<List<NoteEntity>> watchNote(String? categoryId);
  Future<void> insertCategory(CategoryEntity category);
  Future<void> insertNote(NoteEntity note);
  Future<void> deleteNote(String id);
}
