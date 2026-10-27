import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Home page'),
          const SizedBox(height: AppDimensions.spaceXS),
          ElevatedButton(onPressed: () {}, child: const Text('HomeMenuPage')),
        ],
      ),
    );
  }
}
