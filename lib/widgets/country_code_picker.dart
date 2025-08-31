import 'package:flutter/material.dart';

class CountryCodePicker extends StatefulWidget {
  final String selectedCode;
  final Function(String) onChanged;

  const CountryCodePicker({
    super.key,
    required this.selectedCode,
    required this.onChanged,
  });

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  final List<Map<String, String>> _countries = [
    {'code': '+1', 'flag': '🇺🇸', 'name': 'US'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+91', 'flag': '🇮🇳', 'name': 'IN'},
    {'code': '+86', 'flag': '🇨🇳', 'name': 'CN'},
    {'code': '+81', 'flag': '🇯🇵', 'name': 'JP'},
    {'code': '+49', 'flag': '🇩🇪', 'name': 'DE'},
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: widget.onChanged,
      itemBuilder: (BuildContext context) {
        return _countries.map((country) {
          return PopupMenuItem<String>(
            value: country['code'],
            child: Text(
                '${country['flag']} ${country['code']} (${country['name']})'),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _countries.firstWhere(
                (c) => c['code'] == widget.selectedCode,
                orElse: () => _countries.first,
              )['flag']!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Text(
              widget.selectedCode,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
