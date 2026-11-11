import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/features/home/presentation/pages/export_page.dart';
import 'package:all_for_health/features/main_navigation/presentation/pages/main_page.dart';
import 'package:all_for_health/features/catalog/presentation/pages/catalog_page.dart';
import 'package:all_for_health/features/catalog/presentation/pages/save_catalog_page.dart';
import 'package:all_for_health/features/setting/presentation/pages/setting_page.dart';
import 'package:all_for_health/features/home/domain/entities/health_entity.dart';

class AppRouter {
  static const String home = '/';
  static const String homeMenu = '/homeMenu';
  static const String hospital = 'hospital';
  static const String herbs = 'herbs';
  static const String products = 'products';
  static const String cooking = 'cooking';
  static const String microelements = 'microelements';
  static const String sport = 'sport';
  static const String homeDetails = '$homeMenu/homeDetails';
  static const String catalog = '/catalog';
  static const String saveCatalog = '$catalog/saveCatalog';
  static const String settings = '/settings';
}

final GoRouter router = GoRouter(
  initialLocation: AppRouter.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) {
            return MainPage(navigationShell: navigationShell);
          },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'homeMenu',
                  builder: (context, state) {
                    final categoryTitle =
                        state.extra as String? ?? AppRouter.herbs;
                    return HomeMenuPage(categoryTitle: categoryTitle);
                  },
                  routes: [
                    GoRoute(
                      path: 'homeDetails',
                      builder: (context, state) {
                        final data = state.extra as HealthEntity;
                        return HomeDescriptionPage(healthEntity: data);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.catalog,
              builder: (context, state) => const CatalogPage(),
              routes: [
                GoRoute(
                  path: 'saveCatalog',
                  builder: (context, state) => const SaveCatalogPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.settings,
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
