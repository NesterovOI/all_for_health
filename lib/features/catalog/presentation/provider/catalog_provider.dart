import 'package:all_for_health/features/catalog/domain/usecases/get_note_by_id_usecase.dart';
import 'package:all_for_health/features/catalog/domain/usecases/update_note_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/core/database/app_database.dart';
import 'package:all_for_health/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:all_for_health/features/catalog/domain/usecases/manage_catalog_usecase.dart';
import 'package:all_for_health/features/catalog/domain/usecases/watch_categories_usecase.dart';
import 'package:all_for_health/features/catalog/domain/usecases/watch_notes_usecase.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';

// 1. Провайдер екземпляра бази даних
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CatalogRepositoryImpl(db);
});

final watchCategoriesUseCaseProvider = Provider<WatchCategoriesUseCase>((ref) {
  final repo = ref.watch(catalogRepositoryProvider);
  return WatchCategoriesUseCase(repo);
});

final watchNotesUseCasesProvider = Provider<WatchNotesUseCase>((ref) {
  final repo = ref.watch(catalogRepositoryProvider);
  return WatchNotesUseCase(repo);
});

final manageCatalogUseCaseProvider = Provider<ManageCatalogUseCase>((ref) {
  final repo = ref.watch(catalogRepositoryProvider);
  return ManageCatalogUseCase(repo);
});

final getNoteByIdUseCase = Provider<GetNoteByIdUseCase>((ref) {
  final repo = ref.watch(catalogRepositoryProvider);
  return GetNoteByIdUseCase(repo);
});

final updateNoteUseCase = Provider<UpdateNoteUseCase>((ref) {
  final repo = ref.watch(catalogRepositoryProvider);
  return UpdateNoteUseCase(repo);
});

class SelectedCategoryFilterNotifier extends Notifier<String?> {
  @override
  String? build() => null; // Початкове значення

  void selectCategory(String? categoryId) {
    state = categoryId;
  }
}

// 2. Провайдер обраної категорії для фільтрації у Каталозі
final selectedCategoryFilterProvider =
    NotifierProvider<SelectedCategoryFilterNotifier, String?>(
      SelectedCategoryFilterNotifier.new,
    );

// 3. Реактивний стрім категорій
final categoriesStreamProvider = StreamProvider<List<CategoryEntity>>((ref) {
  final useCase = ref.watch(watchCategoriesUseCaseProvider);
  return useCase();
});

// 4. Реактивний стрім нотаток (залежить від обраного фільтра категорії)
final notesStreamProvider = StreamProvider<List<NoteEntity>>((ref) {
  final useCase = ref.watch(watchNotesUseCasesProvider);
  final selectedCategory = ref.watch(selectedCategoryFilterProvider);
  return useCase(categoryId: selectedCategory);
});
