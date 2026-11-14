import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class UpdateNoteUseCase {
  final CatalogRepository _repository;
  UpdateNoteUseCase(this._repository);
  Future<bool> call(NoteEntity note) => _repository.updateNote(note);
}
