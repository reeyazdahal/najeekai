import 'package:flutter/material.dart'; // Add this import
import '../models/community.dart';

class CommunitiesData {
  static final List<Community> dummyCommunities = [
    Community(
      id: '1',
      name: 'Tech Enthusiasts',
      icon: '💻',
      members: 1247,
      tagline: 'Building the future together',
      color: Colors.blue,
      interests: ['Coding', 'AI', 'Gadgets', 'Innovation'],
    ),
    Community(
      id: '2',
      name: 'Book Lovers',
      icon: '📚',
      members: 892,
      tagline: 'Readers become leaders',
      color: Colors.purple,
      interests: ['Reading', 'Literature', 'Book Club', 'Writing'],
    ),
    Community(
      id: '3',
      name: 'Fitness Crew',
      icon: '💪',
      members: 1563,
      tagline: 'Sweat now, shine later',
      color: Colors.green,
      interests: ['Workout', 'Health', 'Nutrition', 'Running'],
    ),
    Community(
      id: '4',
      name: 'Food Explorers',
      icon: '🍕',
      members: 2105,
      tagline: 'Good food, good mood',
      color: Colors.orange,
      interests: ['Cooking', 'Recipes', 'Food Tours', 'Baking'],
    ),
    Community(
      id: '5',
      name: 'Music Makers',
      icon: '🎵',
      members: 978,
      tagline: 'Where melodies meet souls',
      color: Colors.pink,
      interests: ['Music', 'Concerts', 'Instruments', 'Singing'],
    ),
    Community(
      id: '6',
      name: 'Travel Buddies',
      icon: '✈️',
      members: 1342,
      tagline: 'Wander often, wonder always',
      color: Colors.teal,
      interests: ['Travel', 'Adventure', 'Photography', 'Culture'],
    ),
  ];
}
