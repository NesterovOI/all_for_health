import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catalogPageProvider = Provider((ref) => CatalogPage());

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Center(child: Text('CatalogPage')));
  }
}
