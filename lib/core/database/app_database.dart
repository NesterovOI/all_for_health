import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/core/theme/app_strings.dart';

part 'app_database.g.dart';

// 1. Таблиця категорій
class CategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get nameCategory => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}

// 2. Таблиця нотаток
class NotesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get textContent => text()();
  TextColumn get categoryId =>
      text().references(CategoriesTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. Клас бази даних
@DriftDatabase(tables: [CategoriesTable, NotesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await batch((batch) {
        batch.insertAll(categoriesTable, [
          CategoriesTableCompanion.insert(
            id: '1',
            nameCategory: AppStrings.categoryName2,
          ),
          CategoriesTableCompanion.insert(
            id: '2',
            nameCategory: AppStrings.categoryName3,
          ),
          CategoriesTableCompanion.insert(
            id: '3',
            nameCategory: AppStrings.categoryName4,
          ),
          CategoriesTableCompanion.insert(
            id: '4',
            nameCategory: AppStrings.categoryName5,
          ),
          CategoriesTableCompanion.insert(
            id: '5',
            nameCategory: AppStrings.categoryName6,
          ),
          CategoriesTableCompanion.insert(
            id: '6',
            nameCategory: AppStrings.categoryName7,
          ),
        ]);
      });
    },
  );

  // --- МЕТОДИ ДЛЯ КАТЕГОРІЙ ---

  // Отримати всі категорії стрімом (реактивно)
  Stream<List<CategoryEntity>> watchCategories() {
    return (select(categoriesTable))
        .map(
          (row) => CategoryEntity(id: row.id, nameCategory: row.nameCategory),
        )
        .watch();
  }

  // Додати категорію
  Future<int> insertCategory(CategoryEntity category) {
    return into(categoriesTable).insert(
      CategoriesTableCompanion.insert(
        id: category.id,
        nameCategory: category.nameCategory,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  // --- МЕТОДИ ДЛЯ НОТАТОК ---

  // Отримати всі нотатки (з фільтрацією за категорією або без)
  Stream<List<NoteEntity>> watchNotes({String? categoryId}) {
    final query = select(notesTable);

    if (categoryId != null && categoryId != 'all') {
      query.where((tbl) => tbl.categoryId.equals(categoryId));
    }

    return query
        .map(
          (row) => NoteEntity(
            id: row.id,
            name: row.name,
            text: row.textContent,
            categoryId: row.categoryId,
          ),
        )
        .watch();
  }

  // Додати нотатку
  Future<int> insertNote(NoteEntity note) {
    return into(notesTable).insert(
      NotesTableCompanion.insert(
        id: note.id,
        name: note.name,
        textContent: note.text,
        categoryId: note.categoryId,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  // Оновити існуючу нотатку
  Future<bool> updateNote(NoteEntity note) async {
    return await update(notesTable).replace(
      NotesTableCompanion(
        id: Value(note.id),
        name: Value(note.name),
        textContent: Value(note.categoryId),
        categoryId: Value(note.categoryId),
      ),
    );
  }

  Future<NoteEntity?> getNoteById(String id) async {
    final query = select(notesTable)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return NoteEntity(
      id: row.id,
      name: row.name,
      text: row.textContent,
      categoryId: row.categoryId,
    );
  }

  // Видалити нотатку
  Future<int> deleteNote(String id) {
    return (delete(notesTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}

// Відкриття підключення до файлу SQLite на телефоні
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = p.join(dbFolder.path, 'app_database.sqlite');
    return NativeDatabase.createInBackground(File(file));
  });
}
