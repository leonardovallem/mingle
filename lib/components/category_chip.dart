import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  String label;

  CategoryChip({required this.label});

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() => _isSelected = true);
        },
        child: Chip(
          label: Text(widget.label, style: TextStyle(
              color: _isSelected ? const Color(0xFFFF7700) : const Color(0xFF6A515E),
              fontWeight: FontWeight.w600
          )),
          backgroundColor: _isSelected ? const Color(0x3FFA9620) : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
  }
}
