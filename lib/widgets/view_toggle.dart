import 'package:flutter/material.dart';

class ViewToggle extends StatelessWidget {
  final bool isMapView;
  final ValueChanged<bool> onChanged;

  const ViewToggle({
    super.key,
    required this.isMapView,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ToggleButtons(
        isSelected: [isMapView, !isMapView],
        onPressed: (index) => onChanged(index == 0),
        borderRadius: BorderRadius.circular(25),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(Icons.map, size: 20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Icon(Icons.list, size: 20),
          ),
        ],
      ),
    );
  }
}
