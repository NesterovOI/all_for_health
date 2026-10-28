import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:all_for_health/core/navigation/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [const SizedBox(height: AppDimensions.spaceXXM)],
        ),
      ),
    );
  }
}
