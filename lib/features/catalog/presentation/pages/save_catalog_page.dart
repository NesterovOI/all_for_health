import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:all_for_health/features/catalog/presentation/provider/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

final saveCatalogPageProvider = Provider((ref) => SaveCatalogPage());

class SaveCatalogPage extends ConsumerStatefulWidget {
  const SaveCatalogPage({super.key});

  @override
  ConsumerState<SaveCatalogPage> createState() => _SaveCatalogPageState();
}

class _SaveCatalogPageState extends ConsumerState<SaveCatalogPage> {
  final _nameController = TextEditingController();
  final _textController = TextEditingController();
  String? _selectedCategoryId;

  @override
  void dispose() {
    _nameController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    final categoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.newCategory),
        content: TextFormField(
          controller: categoryController,
          decoration: InputDecoration(hintText: AppStrings.newCategory),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final newName = categoryController.text.trim();
              if (newName.isNotEmpty) {
                final newId = DateTime.now().microsecondsSinceEpoch.toString();
                await ref
                    .read(manageCatalogUseCaseProvider)
                    .addCatalog(
                      CategoryEntity(id: newId, nameCategory: newName),
                    );
                setState(() {
                  _selectedCategoryId = newId;
                });
                Navigator.pop(context);
              }
            },
            child: Text(AppStrings.add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.titleSaveCatalog,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceXXM),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: categoriesAsync.when(
                    data: (categories) {
                      return DropdownButtonFormField<String>(
                        value: _selectedCategoryId,
                        hint: const Text(AppStrings.chooseCategory),
                        items: categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat.id,
                            child: Text(cat.nameCategory),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategoryId = value;
                          });
                        },
                      );
                    },
                    error: (_, __) => Text(AppStrings.errorLoadingCategory),
                    loading: () => const LinearProgressIndicator(),
                  ),
                ),
                IconButton(
                  onPressed: () => _showAddCategoryDialog(context, ref),
                  icon: Icon(Icons.add_circle),
                  tooltip: AppStrings.addCategory,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceXS),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppStrings.nameNoteSavePage,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXS),
            Expanded(
              child: TextFormField(
                controller: _textController,
                maxLines: null,
                minLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: AppStrings.textNoteSavePage,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXS),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final text = _textController.text.trim();
                final selectCategory = _selectedCategoryId;
                if (selectCategory != null) {
                  if (name.isNotEmpty && text.isNotEmpty) {
                    final newNote = NoteEntity(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: name,
                      text: text,
                      categoryId: selectCategory,
                    );
                    await ref
                        .read(manageCatalogUseCaseProvider)
                        .addNote(newNote);
                    if (context.mounted) context.pop();
                  }
                }
              },
              child: Text(AppStrings.saveNoteSavePage),
            ),
          ],
        ),
      ),
    );
  }
}
