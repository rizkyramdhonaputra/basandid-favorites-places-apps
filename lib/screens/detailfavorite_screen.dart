import 'dart:io';

import 'package:flutter/material.dart';
import '../models/favoriteplaces_models.dart';
import '../providers/favoritesplaces_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailFavoriteScreen extends ConsumerWidget {
  const DetailFavoriteScreen({super.key, required this.place});

  final FavoritePlacesModels place;

  void _removeFromFavorites(BuildContext context, WidgetRef ref) {
    ref.read(favoritesPlacesProvider.notifier).removeFavoritePlace(place.id);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${place.name} removed from favorites')),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(place.name),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever_rounded),
          onPressed: () => _removeFromFavorites(context, ref),
        ),
      ],
    );
  }

  Widget _showImage() {
    if (place.imagePath != null && place.imagePath!.isNotEmpty) {
      return Image.file(
        File(place.imagePath!),
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.grey,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(place.description),
          const SizedBox(height: 8),
          Text('Rating: ${place.rating}'),
          const SizedBox(height: 16),
          _showImage(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context, ref),
      body: _buildBody(context, ref),
    );
  }
}
