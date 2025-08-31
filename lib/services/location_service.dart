import 'package:flutter/material.dart';

// Mock location service for development
class LocationService {
  static Future<String> requestLocationPermission() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, let's randomly grant or deny permission
    final random = DateTime.now().millisecond % 2;
    return random == 0 ? 'granted' : 'denied';
  }

  static Future<void> showLocationSettings() async {
    // Mock opening settings
    debugPrint('Opening location settings...');
  }
}
