import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;

  const FilterButton({
    super.key,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_list,
        color: isActive ? Colors.blue : Colors.grey,
        size: 28,
      ),
      onPressed: onPressed,
    );
  }
}
