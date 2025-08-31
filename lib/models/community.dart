import 'package:flutter/material.dart'; // Add this import

class Community {
  final String id;
  final String name;
  final String icon;
  final int members;
  final String tagline;
  final Color color;
  final List<String> interests;

  Community({
    required this.id,
    required this.name,
    required this.icon,
    required this.members,
    required this.tagline,
    required this.color,
    required this.interests,
  });
}
