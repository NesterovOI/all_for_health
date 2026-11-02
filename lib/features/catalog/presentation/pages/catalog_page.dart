import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/features/catalog/domain/entities/export_entity.dart';
import 'package:go_router/go_router.dart';

final catalogPageProvider = Provider((ref) => CatalogPage());

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CategoryEntity> catalogItems = [
      CategoryEntity(
        id: '1',
        name: AppStrings.categoryName1,
        colorValue: 0xFFE57373,
      ),
      CategoryEntity(
        id: '2',
        name: AppStrings.categoryName2,
        colorValue: 0xFFE57373,
      ),
      CategoryEntity(
        id: '3',
        name: AppStrings.categoryName3,
        colorValue: 0xFFE57373,
      ),
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
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceXXS,
                    ),
                    child: Card(
                      color: category.color,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                        onTap: () {
                          context.go(AppStrings.navSave);
                        },
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXS),
          ],
        ),
      ),
    );
  }
}
