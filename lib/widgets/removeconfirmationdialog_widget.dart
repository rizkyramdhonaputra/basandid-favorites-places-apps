import 'package:aplikasi_favoritesplaces/models/favoriteplaces_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favoritesplaces_provider.dart';

class RemoveConfirmationDialog extends ConsumerWidget {
  final FavoritePlacesModels place;

  const RemoveConfirmationDialog({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        'Remove Favorite Place',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: Text(
        'Are you sure you want to remove this ${place.name} from your favorites?',
        style: TextTheme.of(
          context,
        ).bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(favoritesPlacesProvider.notifier)
                .removeFavoritePlace(place.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${place.name} removed from favorites')),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Remove'),
        ),
      ],
    );
  }
}
