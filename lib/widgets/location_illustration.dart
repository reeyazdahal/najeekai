import 'package:flutter/material.dart';

class LocationIllustration extends StatefulWidget {
  const LocationIllustration({super.key});

  @override
  State<LocationIllustration> createState() => _LocationIllustrationState();
}

class _LocationIllustrationState extends State<LocationIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circles with pulse animation
          _buildPulsingCircle(80, Colors.blue.withOpacity(0.1)),
          _buildPulsingCircle(60, Colors.blue.withOpacity(0.2)),

          // Main location pin
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.blue[700],
            ),
          ),

          // Small people around the location
          Positioned(
            top: 30,
            left: 40,
            child: _buildPerson(Colors.orange),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: _buildPerson(Colors.green),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: _buildPerson(Colors.purple),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: _buildPerson(Colors.pink),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + 0.4 * _controller.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerson(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
