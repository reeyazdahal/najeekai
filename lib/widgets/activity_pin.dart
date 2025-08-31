import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivityPin extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;
  final bool isSelected;

  const ActivityPin({
    super.key,
    required this.activity,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSelected ? 50 : 40,
        height: isSelected ? 50 : 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[600] : Colors.blue[500],
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          activity.icon,
          size: isSelected ? 24 : 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
