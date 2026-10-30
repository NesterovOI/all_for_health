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
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                      onTap: () => context.go(AppRouter.homeMenu),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusM,
                            ),
                            child: Image.asset(
                              'assets/images/menu/menu1.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Мікроелементи',
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
