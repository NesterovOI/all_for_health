import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/core/navigation/app_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'title': 'hospital', 'name': AppStrings.categoryName2},
      {'title': 'herbs', 'name': AppStrings.categoryName3},
      {'title': 'products', 'name': AppStrings.categoryName4},
      {'title': 'cooking', 'name': AppStrings.categoryName5},
      {'title': 'microelements', 'name': AppStrings.categoryName6},
      {'title': 'sport', 'name': AppStrings.categoryName7},
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
                prefix: Icon(Icons.search, size: AppDimensions.spaceXXXL),
                suffix: IconButton(
                  onPressed: () => _searchController.clear(),
                  icon: Icon(Icons.clear, size: AppDimensions.spaceXXXL),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.spaceS),
            Text(
              AppStrings.menu,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: GridView.builder(
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
                  if (name != null && name.isNotEmpty) {
                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                        onTap: () => context.go(
                          AppRouter.homeMenu,
                          extra: category['title'],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                              child: Image.asset(
                                'assets/images/menu/menu$index.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
