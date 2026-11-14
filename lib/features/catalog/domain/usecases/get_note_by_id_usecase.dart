import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/domain/repositories/catalog_repository.dart';

class GetNoteByIdUseCase {
  final CatalogRepository _repository;

  GetNoteByIdUseCase(this._repository);
  Future<NoteEntity?> call(String id) => _repository.getNoteById(id);
}
