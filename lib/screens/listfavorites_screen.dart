import 'package:aplikasi_favoritesplaces/models/favoriteplaces_models.dart';
import 'package:aplikasi_favoritesplaces/widgets/removeconfirmationdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favoritesplaces_provider.dart';
import '../routes/apps_routes.dart';
import 'detailfavorite_screen.dart';

class ListFavoriteScreen extends ConsumerWidget {
  const ListFavoriteScreen({super.key});

  AppBar _buildAppBar(BuildContext context, WidgetRef ref, bool isLoading) {
    return AppBar(
      title: Center(
        child: Text(
          'Favorites Places',
          style: TextTheme.of(context).headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        if (!isLoading)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(favoritesPlacesProvider),
          ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Failed to load favorite places.',
            style: TextTheme.of(context).headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => ref.invalidate(favoritesPlacesProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No favorite places added yet.',
        style: TextTheme.of(context).headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  void _navigateToDetail(BuildContext context, FavoritePlacesModels place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailFavoriteScreen(place: place),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<FavoritePlacesModels>> favoritesPlaces,
  ) {
    return favoritesPlaces.when(
      data: (listPlaces) {
        if (listPlaces.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          itemCount: listPlaces.length,
          itemBuilder: (context, index) {
            final place = listPlaces[index];
            return ListTile(
              title: Text(
                place.name,
                style: TextTheme.of(context).titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              subtitle: Text(
                place.description,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              trailing: Text(
                'Rating: ${place.rating}',
                style: TextTheme.of(context).bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () {
                _navigateToDetail(context, place);
                // Handle tap if needed
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => RemoveConfirmationDialog(place: place),
                );
                // Handle long press if needed
              },
            );
          },
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(context, ref),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesPlaces = ref.watch(favoritesPlacesProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ref, favoritesPlaces.isLoading),
      body: _buildBody(context, ref, favoritesPlaces),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppsRoutes.addPlace),
        child: const Icon(Icons.add),
      ),
    );
  }
}
