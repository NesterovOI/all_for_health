import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saveCatalogPageProvider = Provider((ref) => SaveCatalogPage());

class SaveCatalogPage extends ConsumerWidget {
  const SaveCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
