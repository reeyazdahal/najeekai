import 'package:flutter/material.dart';
import '../widgets/location_illustration.dart';
import '../constants/colors.dart';
import '../main.dart'; // Import MainApp for navigation

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  bool _isRequesting = false;
  bool _showPermissionDeniedBanner = false;

  Future<void> _requestLocationPermission() async {
    setState(() {
      _isRequesting = true;
      _showPermissionDeniedBanner = false;
    });

    try {
      // Simulate permission request delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo, let's assume permission is granted 70% of the time
      final random = DateTime.now().millisecond % 10;
      final isGranted = random < 7;

      if (isGranted) {
        // Permission granted - navigate to main app with bottom navigation
        _navigateToMainApp();
      } else {
        // Permission denied
        setState(() {
          _showPermissionDeniedBanner = true;
        });

        // Auto-hide banner after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showPermissionDeniedBanner = false;
            });
          }
        });
      }
    } catch (e) {
      // Handle any errors
      setState(() {
        _showPermissionDeniedBanner = true;
      });
    } finally {
      setState(() {
        _isRequesting = false;
      });
    }
  }

  void _navigateToMainApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const MainApp(), // Navigate to MainApp with bottom navigation
      ),
    );
  }

  void _skipLocation() {
    // Navigate to main app without location permission
    _navigateToMainApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Illustration
                const LocationIllustration(),

                const SizedBox(height: 40),

                // Title
                Text(
                  'Discover Nearby Activities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  'We show activities near you. Your exact location isn\'t shared with other users.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Enable Location Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isRequesting ? null : _requestLocationPermission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: _isRequesting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text(
                            'Enable Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // Not Now Button
                TextButton(
                  onPressed: _isRequesting ? null : _skipLocation,
                  child: const Text(
                    'Not Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Permission denied banner (non-blocking)
          if (_showPermissionDeniedBanner)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _buildPermissionDeniedBanner(),
            ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedBanner() {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.orange[700],
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'You can enable location later in Settings',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: () {
                setState(() {
                  _showPermissionDeniedBanner = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
