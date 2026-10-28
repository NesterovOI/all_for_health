import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:all_for_health/core/theme/app_theme.dart';
import 'package:all_for_health/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme);
  }
}
