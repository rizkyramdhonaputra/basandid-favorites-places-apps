import '../models/favoriteplaces_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPlacesNotifier
    extends AsyncNotifier<List<FavoritePlacesModels>> {
  @override
  Future<List<FavoritePlacesModels>> build() async {
    // Simulate fetching data from a database or API
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<void> addFavoritePlace(FavoritePlacesModels place) async {
    final currentPlaces = state.value ?? [];
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      final newPlace = FavoritePlacesModels(
        id: place.id,
        name: place.name,
        description: place.description,
        rating: place.rating,
      );
      return [...currentPlaces, newPlace];
    });
  }

  Future<void> removeFavoritePlace(String id) async {
    final currentPlaces = state.value ?? [];
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      return currentPlaces.where((place) => place.id != id).toList();
    });
  }
}

final favoritesPlacesProvider =
    AsyncNotifierProvider<FavoritesPlacesNotifier, List<FavoritePlacesModels>>(
      FavoritesPlacesNotifier.new,
    );
