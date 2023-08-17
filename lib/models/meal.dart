// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/foundation.dart';

enum Complexity {
  // ignore: constant_identifier_names
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Luxurious,
  Pricey,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final Affordability affordability;
  final Complexity complexity;

  Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
    required this.affordability,
    required this.complexity,
  });
}
