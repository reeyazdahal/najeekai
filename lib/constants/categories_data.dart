import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoriesData {
  static final List<Category> allCategories = [
    Category(
      id: 'sports',
      name: 'Sports 🏀',
      icon: Icons.sports_basketball,
      color: Colors.orange,
    ),
    Category(
      id: 'food',
      name: 'Food & Drinks 🍕',
      icon: Icons.restaurant,
      color: Colors.red,
    ),
    Category(
      id: 'tech',
      name: 'Tech & Coding 💻',
      icon: Icons.computer,
      color: Colors.blue,
    ),
    Category(
      id: 'outdoors',
      name: 'Outdoors 🌳',
      icon: Icons.nature,
      color: Colors.green,
    ),
    Category(
      id: 'arts',
      name: 'Arts & Culture 🎨',
      icon: Icons.palette,
      color: Colors.purple,
    ),
    Category(
      id: 'music',
      name: 'Music 🎵',
      icon: Icons.music_note,
      color: Colors.pink,
    ),
    Category(
      id: 'games',
      name: 'Games 🎮',
      icon: Icons.videogame_asset,
      color: Colors.teal,
    ),
    Category(
      id: 'fitness',
      name: 'Fitness 💪',
      icon: Icons.fitness_center,
      color: Colors.blueGrey,
    ),
    Category(
      id: 'social',
      name: 'Social 🎉',
      icon: Icons.people,
      color: Colors.amber,
    ),
    Category(
      id: 'learning',
      name: 'Learning 📚',
      icon: Icons.school,
      color: Colors.indigo,
    ),
  ];
}