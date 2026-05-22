import 'package:aplikasi_favoritesplaces/screens/addfavorite_screen.dart';
import 'package:flutter/material.dart';
import '../screens/listfavorites_screen.dart';

class AppsRoutes {
  static const String placesList = '/';
  static const String addPlace = '/add-place';
  static const String placeDetail = '/place-detail';

  static Map<String, Widget Function(BuildContext)> getRoutes() => {
    placesList: (final context) => const ListFavoriteScreen(),
    addPlace: (final context) => const AddFavoriteScreen(),
    // Add your screen mappings here, for example:
    // placesList: (final context) => const PlacesListScreen(),
  };
}
