import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:all_for_health/features/catalog/presentation/provider/catalog_provider.dart';

class CatalogPage extends ConsumerStatefulWidget {
  const CatalogPage({super.key});

  @override
  ConsumerState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCategory = CategoryEntity(
      id: 'all',
      nameCategory: AppStrings.categoryName1,
    );
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final notesAsync = ref.watch(notesStreamProvider);
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.titleCatalog,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceXS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppDimensions.spaceXL,
              child: categoriesAsync.when(
                data: (categories) {
                  final listWithAll = [allCategory, ...categories];
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listWithAll.length,
                    itemBuilder: (context, index) {
                      final category = listWithAll[index];
                      final isSelected =
                          (selectedCategory == category.id) ||
                          (selectedCategory == null && category.id == 'all');
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.radiusXXS,
                        ),
                        child: ChoiceChip(
                          label: Text(
                            category.nameCategory,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            ref
                                .read(selectedCategoryFilterProvider.notifier)
                                .selectCategory(
                                  (category.id == 'all') ? null : category.id,
                                );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('${AppStrings.errorLoading}$err'),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXXXM),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.hintText,
                prefixIcon: const Icon(
                  Icons.search,
                  size: AppDimensions.spaceXXXL,
                ),
                suffixIcon: IconButton(
                  onPressed: () => _searchController.clear(),
                  icon: const Icon(Icons.clear, size: AppDimensions.spaceXXXL),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXXXM),
            Expanded(
              child: notesAsync.when(
                data: (notes) {
                  if (notes.isEmpty) {
                    return Center(child: Text(AppStrings.emptyCategory));
                  }
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: AppDimensions.spaceXS,
                        ),
                        child: ListTile(
                          title: Text(
                            note.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            note.text,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .read(manageCatalogUseCaseProvider)
                                  .deleteNote(note.id);
                            },
                            icon: Icon(Icons.delete, color: AppColors.error),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (err, stack) => Text('${AppStrings.errorLoading}$err'),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRouter.saveCatalog);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
