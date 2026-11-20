import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:all_for_health/core/theme/app_health_category_ids.dart';
import 'package:all_for_health/features/home/presentation/providers/health_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _searchController = TextEditingController();

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final isSearching = query.isNotEmpty;

    final List<Map<String, String>> categories = [
      {'title': AppHealthCategoryIds.herbs, 'name': AppStrings.categoryHerbs},
      {
        'title': AppHealthCategoryIds.recipes,
        'name': AppStrings.categoryRecipes,
      },
      {
        'title': AppHealthCategoryIds.diseases,
        'name': AppStrings.categoryDiseases,
      },
      {
        'title': AppHealthCategoryIds.microelements,
        'name': AppStrings.categoryMicroelements,
      },
      {
        'title': AppHealthCategoryIds.products,
        'name': AppStrings.categoryProducts,
      },
      {
        'title': AppHealthCategoryIds.cooking,
        'name': AppStrings.categoryCooking,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.all_for_health,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceXXM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.hintText,
                prefixIcon: const Icon(
                  Icons.search,
                  size: AppDimensions.spaceXXXL,
                ),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => _searchController.clear(),
                        icon: const Icon(
                          Icons.clear,
                          size: AppDimensions.spaceXXXL,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              isSearching ? AppStrings.hintText : AppStrings.menu,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spaceXS),
            Expanded(
              child: isSearching
                  ? _buildSearchResults(context, query)
                  : _buildCategoriesGrid(context, categories),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(
    BuildContext context,
    List<Map<String, String>> categories,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.spaceXS,
        mainAxisSpacing: AppDimensions.spaceXS,
        childAspectRatio: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final name = category['name'];
        final categoryTitle = category['title'];

        if (name == null || name.isEmpty || categoryTitle == null) {
          return const SizedBox.shrink();
        }

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            onTap: () => context.go(AppRouter.homeMenu, extra: categoryTitle),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    child: Image.asset(
                      'assets/images/menu/menu$index.webp',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.spa_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceXXS),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, String query) {
    final searchAsync = ref.watch(searchHealthProvider(query));

    return searchAsync.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text(
              AppStrings.emptyCategory,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.error),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                onTap: () => context.push(AppRouter.homeDetails, extra: item),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceS),
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppDimensions.spaceL,
                        height: AppDimensions.spaceL,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          child: Image.asset(
                            item.image ?? '',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.spa_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceS),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(AppStrings.errorLoading + error.toString())),
    );
  }
}
