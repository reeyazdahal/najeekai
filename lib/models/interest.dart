import 'package:flutter/material.dart';

class Interest {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Interest({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Interest && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
