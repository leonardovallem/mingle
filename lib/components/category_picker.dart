import 'package:flutter/material.dart';
import 'package:projects/util/no_glow_scroll.dart';

import 'category_chip.dart';

class CategoryPicker extends StatefulWidget {
  List<String> categories;

  CategoryPicker(this.categories);

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollGlow(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          return CategoryChip(
            label: widget.categories[position],
            onTap: () {
              setState(() => _selected = position);
            },
            active: position == _selected,
          );
        },
        itemCount: widget.categories.length,
      ),
    );
  }
}
