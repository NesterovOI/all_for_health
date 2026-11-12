import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/core/database/app_database.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';

// 1. Провайдер екземпляра бази даних
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
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

// 3. Реактивний стрім категорій із бази
final categoriesStreamProvider = StreamProvider<List<CategoryEntity>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchCategories();
});

// 4. Реактивний стрім нотаток (залежить від обраного фільтра категорії)
final notesStreamProvider = StreamProvider<List<NoteEntity>>((ref) {
  final db = ref.watch(databaseProvider);
  final selectedCategory = ref.watch(selectedCategoryFilterProvider);
  return db.watchNotes(categoryId: selectedCategory);
});
