import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/features/home/presentation/pages/export_page.dart';
import 'package:all_for_health/features/main_navigation/presentation/pages/main_page.dart';
import 'package:all_for_health/features/catalog/presentation/pages/catalog_page.dart';
import 'package:all_for_health/features/setting/presentation/pages/setting_page.dart';

class AppRouter {
  static const String home = '/';
  static const String homeMenu = 'homeMenu';
  static const String homeDetails = 'homeDetails';
  static const String catalog = '/catalog';
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
              builder: (context, state) => HomePage(),
              routes: [
                GoRoute(
                  path: AppRouter.homeMenu,
                  builder: (context, state) => HomeMenuPage(),
                  routes: [
                    GoRoute(
                      path: AppRouter.homeDetails,
                      builder: (context, state) => HomeDescriptionPage(),
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
              builder: (context, state) => CatalogPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.settings,
              builder: (context, state) => SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
