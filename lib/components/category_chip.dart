import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  String label;
  bool? active = false;
  VoidCallback onTap;

  CategoryChip({required this.label, this.active, required this.onTap});

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(widget.onTap);
        },
        child: Chip(
          label: Text(widget.label, style: TextStyle(
              color: widget.active! ? const Color(0xFFFF7700) : const Color(0xFF6A515E),
              fontWeight: FontWeight.w600
          )),
          backgroundColor: widget.active! ? const Color(0x3FFA9620) : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
  }
}
