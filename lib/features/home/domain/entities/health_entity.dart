class HealthEntity {
  final String id;
  final String title;
  final String name;
  final String description;
  final String health;
  final String? youTube;
  final String? image;

  const HealthEntity({
    required this.id,
    required this.title,
    required this.name,
    required this.description,
    required this.health,
    this.youTube,
    this.image,
  });
}
