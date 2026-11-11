import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/core/theme/theme.dart';

final saveCatalogPageProvider = Provider((ref) => SaveCatalogPage());

class SaveCatalogPage extends ConsumerWidget {
  const SaveCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.titleSaveCatalog,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          AppStrings.emptyCategory,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
