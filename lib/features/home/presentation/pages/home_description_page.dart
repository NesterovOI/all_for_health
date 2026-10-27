import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';

class HomeDescriptionPage extends StatelessWidget {
  const HomeDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomeDescriptionPage'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text('HomeDescriptionPage'),
            const SizedBox(height: AppDimensions.spaceXS),
            ElevatedButton(onPressed: () {}, child: Text('Go')),
          ],
        ),
      ),
    );
  }
}
