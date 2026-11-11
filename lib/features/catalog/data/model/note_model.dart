import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    required super.id,
    required super.name,
    required super.text,
    required super.categoryId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      text: json['text'] as String,
      categoryId: json['categoryId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'text': text, 'categoryId': categoryId};
  }
}
