import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasi_favoritesplaces/routes/apps_routes.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.dark,
  surface: Colors.black,
);

final theme = ThemeData().copyWith(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    titleSmall: GoogleFonts.lato(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.lato(fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.lato(fontWeight: FontWeight.bold),
  ),
);

void main() {
  runApp(ProviderScope(child: const FavoritesPlacesApp()));
}

class FavoritesPlacesApp extends StatelessWidget {
  const FavoritesPlacesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: AppsRoutes.placesList,
      routes: AppsRoutes.getRoutes(),
    );
  }
}
