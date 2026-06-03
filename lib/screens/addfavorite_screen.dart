import 'dart:io';

import 'package:aplikasi_favoritesplaces/widgets/imageinput_widget.dart';
import 'package:aplikasi_favoritesplaces/widgets/locationinput_widget.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_favoritesplaces/providers/favoritesplaces_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasi_favoritesplaces/models/favoriteplaces_models.dart';
import 'package:uuid/uuid.dart';

class AddFavoriteScreen extends ConsumerStatefulWidget {
  const AddFavoriteScreen({super.key});

  @override
  ConsumerState<AddFavoriteScreen> createState() => _AddFavoriteScreenState();
}

class _AddFavoriteScreenState extends ConsumerState<AddFavoriteScreen> {
  final _formKey = GlobalKey<FormState>();
  String _placeName = '';
  String _placeDescription = '';
  double _placeRating = 0.0;
  final uuid = const Uuid();
  File? _placeImage;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(title: const Text('Add Favorite Place'));
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Place Name',
        hintText: 'Enter the name of the place',
        labelStyle: TextTheme.of(context).titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextTheme.of(
          context,
        ).bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a place name';
        }
        return null;
      },
      onSaved: (value) {
        _placeName = value!;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Place Description',
        hintText: 'Enter a brief description of the place',
        labelStyle: TextTheme.of(context).titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextTheme.of(
          context,
        ).bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a place description';
        }
        return null;
      },
      onSaved: (value) {
        _placeDescription = value!;
      },
    );
  }

  Widget _buildRatingField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Place Rating (0.0 - 5.0)',
        hintText: 'Enter a rating between 0.0 and 5.0',
        labelStyle: TextTheme.of(context).titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextTheme.of(
          context,
        ).bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a place rating';
        }
        final rating = double.tryParse(value);
        if (rating == null || rating < 0.0 || rating > 5.0) {
          return 'Please enter a valid rating between 0.0 and 5.0';
        }
        return null;
      },
      onSaved: (value) {
        _placeRating = double.parse(value!);
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPlace = FavoritePlacesModels(
        id: uuid.v4(), // Generate a unique ID for the new place
        name: _placeName,
        description: _placeDescription,
        rating: _placeRating,
        imagePath: _placeImage?.path,
      );
      ref.read(favoritesPlacesProvider.notifier).addFavoritePlace(newPlace);
      Navigator.pop(context, _placeName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$_placeName added to favorites!')),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _placeName = '';
      _placeDescription = '';
      _placeRating = 0.0;
    });
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildNameField(),
            const SizedBox(height: 16),
            _buildDescriptionField(),
            const SizedBox(height: 16),
            _buildRatingField(),
            const SizedBox(height: 32),
            ImageInput(),
            const SizedBox(height: 16),
            LocationInput(),
            const SizedBox(height: 32), // Add the LocationInput widget here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _resetForm,
                  child: const Text(
                    'Reset Form',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Place'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildForm());
  }
}
