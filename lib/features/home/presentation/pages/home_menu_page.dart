import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/features/home/presentation/providers/health_providers.dart';

class HomeMenuPage extends ConsumerStatefulWidget {
  final String categoryTitle;

  const HomeMenuPage({super.key, required this.categoryTitle});

  @override
  ConsumerState<HomeMenuPage> createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends ConsumerState<HomeMenuPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthListAsync = ref.watch(healthListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Title', style: Theme.of(context).textTheme.titleMedium),
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
                prefix: Icon(Icons.search, size: AppDimensions.spaceXXXL),
                suffix: IconButton(
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
                data: (healthList) {
                  if (healthList.isEmpty) {
                    return Center(
                      child: Text(
                        AppStrings.errorLoading,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: healthList.length,
                    itemBuilder: (context, index) {
                      final item = healthList[index];
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          onTap: () =>
                              context.go(AppRouter.homeDetails, extra: item),
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
