import 'package:flutter/material.dart';
import 'package:all_for_health/core/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDescriptionPage extends StatelessWidget {
  final String name;
  final String filePath;

  const HomeDescriptionPage({
    super.key,
    required this.name,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.spaceM),
            child: Image.asset(
              'assets/images/menu/menu1.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          FutureBuilder<String>(
            future: rootBundle.loadString(filePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    AppStrings.errorLoading + snapshot.error.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                );
              }
              return Markdown(
                data: snapshot.data ?? '',
                styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                  p: theme.textTheme.bodyMedium,
                  h1: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  h2: theme.textTheme.titleMedium,
                  a: TextStyle(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTapLink: (text, href, name) async {
                  if (href != null) {
                    final url = Uri.parse(href);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
