import 'package:flutter/material.dart';
import '../models/interest.dart';

class InterestsData {
  static final List<Interest> allInterests = [
    Interest(
      id: 'music',
      name: 'Music',
      icon: Icons.music_note,
      color: Colors.purple,
    ),
    Interest(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_basketball,
      color: Colors.orange,
    ),
    Interest(
      id: 'art',
      name: 'Art',
      icon: Icons.palette,
      color: Colors.pink,
    ),
    Interest(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant,
      color: Colors.red,
    ),
    Interest(
      id: 'travel',
      name: 'Travel',
      icon: Icons.travel_explore,
      color: Colors.blue,
    ),
    Interest(
      id: 'tech',
      name: 'Tech',
      icon: Icons.computer,
      color: Colors.blueGrey,
    ),
    Interest(
      id: 'books',
      name: 'Books',
      icon: Icons.menu_book,
      color: Colors.brown,
    ),
    Interest(
      id: 'gaming',
      name: 'Gaming',
      icon: Icons.videogame_asset,
      color: Colors.green,
    ),
    Interest(
      id: 'fitness',
      name: 'Fitness',
      icon: Icons.fitness_center,
      color: Colors.teal,
    ),
    Interest(
      id: 'movies',
      name: 'Movies',
      icon: Icons.movie,
      color: Colors.indigo,
    ),
  ];
}
