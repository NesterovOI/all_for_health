import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/core/navigation/app_router.dart';

final catalogPageProvider = Provider((ref) => CatalogPage());

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<CategoryEntity> catalogItems = [
      CategoryEntity(id: '1', nameCategory: AppStrings.categoryName1),
      CategoryEntity(id: '2', nameCategory: AppStrings.categoryName2),
      CategoryEntity(id: '3', nameCategory: AppStrings.categoryName3),
      CategoryEntity(id: '4', nameCategory: AppStrings.categoryName4),
      CategoryEntity(id: '5', nameCategory: AppStrings.categoryName5),
      CategoryEntity(id: '6', nameCategory: AppStrings.categoryName6),
      CategoryEntity(id: '7', nameCategory: AppStrings.categoryName7),
    ];
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catalogItems.length,
                itemBuilder: (context, index) {
                  final category = catalogItems[index];
                  return Card(
                    color: isDark
                        ? AppColors.darkBackground
                        : AppColors.lightBackground,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                      onTap: () {
                        //Потрібно додати логіку для вибору категорії із списку
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceXS),
                        child: Text(
                          category.nameCategory,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  );
                },
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceXS,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.nameNote,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(height: AppDimensions.spaceXXXS),
                              Text(
                                AppStrings.nameCategory,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            size: AppDimensions.spaceXXXL,
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
