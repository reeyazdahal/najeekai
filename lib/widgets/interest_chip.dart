import 'package:flutter/material.dart';
import '../models/interest.dart';

class InterestChip extends StatefulWidget {
  final Interest interest;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const InterestChip({
    super.key,
    required this.interest,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<InterestChip> createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant InterestChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward().then((_) => _controller.reverse());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FilterChip(
        selected: widget.isSelected,
        onSelected: widget.onSelected,
        label: Text(
          widget.interest.name,
          style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        avatar: Icon(
          widget.interest.icon,
          size: 18,
          color: widget.isSelected ? Colors.white : widget.interest.color,
        ),
        backgroundColor: Colors.white,
        selectedColor: widget.interest.color,
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: widget.isSelected ? widget.interest.color : Colors.grey[300]!,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        showCheckmark: true,
      ),
    );
  }
}
