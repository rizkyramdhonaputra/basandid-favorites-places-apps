class FavoritePlacesModels {
  final String id;
  final String name;
  final String description;
  final double rating;
  final String? imagePath;

  FavoritePlacesModels({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    this.imagePath,
  });
}
