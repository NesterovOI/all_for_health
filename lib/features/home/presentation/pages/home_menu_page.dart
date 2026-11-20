import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/features/home/presentation/providers/health_providers.dart';
import 'package:all_for_health/features/home/domain/entities/health_entity.dart';

class HomeMenuPage extends ConsumerStatefulWidget {
  final String categoryTitle;

  const HomeMenuPage({super.key, required this.categoryTitle});

  @override
  ConsumerState<HomeMenuPage> createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends ConsumerState<HomeMenuPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  List<HealthEntity> _filterItems(List<HealthEntity> items) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items.where((item) {
      final nameMatches = item.name.toLowerCase().contains(query);
      final descriptionMatches = item.description.toLowerCase().contains(query);
      final titleMatches = item.title.toLowerCase().contains(query);
      return nameMatches || descriptionMatches || titleMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final healthListAsync = ref.watch(
      healthListByCategoryProvider(widget.categoryTitle),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
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
                prefixIcon: Icon(Icons.search, size: AppDimensions.spaceXXXL),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => _searchController.clear(),
                        icon: Icon(Icons.clear, size: AppDimensions.spaceXXXL),
                      ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              AppStrings.menu,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: healthListAsync.when(
                skipLoadingOnRefresh: true,
                skipLoadingOnReload: true,
                data: (healthList) {
                  final filteredList = _filterItems(healthList);
                  if (filteredList.isEmpty) {
                    return Center(
                      child: Text(
                        AppStrings.emptyCategory,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          onTap: () =>
                              context.push(AppRouter.homeDetails, extra: item),
                          child: Padding(
                            padding: const EdgeInsets.all(AppDimensions.spaceS),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                SizedBox(width: AppDimensions.spaceS),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Text(
                                        item.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
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
                error: (error, stack) => Center(
                  child: Text(AppStrings.errorLoading + error.toString()),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
