import 'package:flutter/material.dart';
import 'package:projects/components/ingredient_indicator.dart';
import 'package:projects/components/new_ingredient_dialog.dart';
import 'package:projects/model/dto/used_ingredient_dto.dart';
import 'package:projects/util/list_items_controller.dart';
import 'package:projects/util/no_glow_scroll.dart';

import 'mingle_large_button.dart';

class IngredientsList extends StatefulWidget {
  ListItemsController<UsedIngredientDTO> controller;

  IngredientsList({required this.controller});

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), color: const Color(0x33AA4400)),
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScroll(),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return IngredientIndicator(widget.controller.items[index],
                      onDelete: () => setState(() => widget.controller.items.removeAt(index)));
                },
                itemCount: widget.controller.items.length,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MingleLargeButton(
              label: "adicionar ingrediente",
              icon: Icons.add,
              onClick: () => showDialog(
                  context: context,
                  builder: (context) => NewIngredientDialog(widget.controller.items, update: () => setState(() {})),
                ),
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}
