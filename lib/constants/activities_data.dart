import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivitiesData {
  static final List<Activity> dummyActivities = [
    Activity(
      id: '1',
      title: 'Kathmandu Heritage Walk',
      description:
          'Explore ancient temples and historical sites in the heart of Kathmandu',
      category: 'Culture',
      icon: Icons.temple_buddhist,
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      latitude: 27.7045, // Kathmandu coordinates
      longitude: 85.3075,
      participants: 12,
      organizer: 'Heritage Nepal',
    ),
    Activity(
      id: '2',
      title: 'Thamel Coffee & Coding',
      description: 'Working on tech projects together at a cozy café in Thamel',
      category: 'Tech',
      icon: Icons.coffee,
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      latitude: 27.7145, // Thamel area
      longitude: 85.3120,
      participants: 8,
      organizer: 'Tech Nepal',
    ),
    Activity(
      id: '3',
      title: 'Yoga at Garden of Dreams',
      description: 'Morning yoga session in the beautiful Garden of Dreams',
      category: 'Wellness',
      icon: Icons.self_improvement,
      startTime: DateTime.now().add(const Duration(hours: 3)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      latitude: 27.7130, // Garden of Dreams
      longitude: 85.3150,
      participants: 15,
      organizer: 'Yoga Nepal',
    ),
    Activity(
      id: '4',
      title: 'Book Club at Nepal National Library',
      description: 'Discussing contemporary Nepali literature',
      category: 'Social',
      icon: Icons.menu_book,
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      latitude: 27.7080, // Near National Library
      longitude: 85.3200,
      participants: 6,
      organizer: 'Kathmandu Readers',
    ),
    Activity(
      id: '5',
      title: 'Running Group - Ring Road',
      description: '5k run around Kathmandu Ring Road',
      category: 'Fitness',
      icon: Icons.directions_run,
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      latitude: 27.7190, // Ring Road area
      longitude: 85.3300,
      participants: 20,
      organizer: 'Run Nepal',
    ),
    Activity(
      id: '6',
      title: 'Street Food Tour - Ason Market',
      description: 'Exploring local delicacies in Ason market',
      category: 'Food',
      icon: Icons.restaurant,
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      latitude: 27.7060, // Ason Market
      longitude: 85.3100,
      participants: 10,
      organizer: 'Foodie Kathmandu',
    ),
  ];
}
