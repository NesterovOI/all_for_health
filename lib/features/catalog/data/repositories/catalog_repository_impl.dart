import 'package:all_for_health/core/database/app_database.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl extends CatalogRepository {
  final AppDatabase _database;
  CatalogRepositoryImpl(this._database);

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    return _database.watchCategories().map((rows) {
      return rows
          .map(
            (row) => CategoryEntity(id: row.id, nameCategory: row.nameCategory),
          )
          .toList();
    });
  }

  @override
  Stream<List<NoteEntity>> watchNote({String? categoryId}) {
    return _database.watchNotes().map((rows) {
      return rows
          .map(
            (row) => NoteEntity(
              id: row.id,
              name: row.name,
              text: row.text,
              categoryId: row.categoryId,
            ),
          )
          .toList();
    });
  }

  @override
  Future<void> insertCategory(CategoryEntity category) async {
    await _database.insertCategory(category);
  }

  @override
  Future<void> insertNote(NoteEntity note) async {
    await _database.insertNote(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _database.deleteNote(id);
  }
}
