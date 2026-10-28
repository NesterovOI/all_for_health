import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:all_for_health/core/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomeMenuPage'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text('HomeMenuPage'),
            ElevatedButton(
              onPressed: () => context.go('/homeMenu/homeDetails'),
              child: Text('HomeDescriptionPage'),
            ),
          ],
        ),
      ),
    );
  }
}
