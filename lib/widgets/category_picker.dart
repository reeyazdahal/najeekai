import 'package:flutter/material.dart';
import '../constants/categories_data.dart';

class CategoryPicker extends StatefulWidget {
  final Category? selectedCategory;
  final ValueChanged<Category?> onCategorySelected;

  const CategoryPicker({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category *',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Category>(
          value: _selectedCategory,
          decoration: InputDecoration(
            hintText: 'Choose a category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: CategoriesData.allCategories.map((category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Row(
                children: [
                  Icon(category.icon, color: category.color, size: 20),
                  const SizedBox(width: 12),
                  Text(category.name),
                ],
              ),
            );
          }).toList(),
          onChanged: (category) {
            setState(() {
              _selectedCategory = category;
            });
            widget.onCategorySelected(category);
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a category';
            }
            return null;
          },
        ),
      ],
    );
  }
}