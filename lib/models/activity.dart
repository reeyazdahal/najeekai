import 'package:flutter/material.dart'; // Add this import

class Activity {
  final String id;
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final DateTime startTime;
  final DateTime endTime;
  final double latitude;
  final double longitude;
  final int participants;
  final String organizer;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.participants,
    required this.organizer,
  });

  String get timeDisplay {
    final now = DateTime.now();
    final difference = startTime.difference(now);

    if (difference.inDays > 0) {
      return 'In ${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return 'In ${difference.inHours}h';
    } else {
      return 'Now';
    }
  }

  String get duration {
    final diff = endTime.difference(startTime);
    if (diff.inHours > 0) {
      return '${diff.inHours}h';
    } else {
      return '${diff.inMinutes}m';
    }
  }
}
