import 'package:flutter/material.dart';
import 'package:projects/components/mingle_dropdown_button.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/util/no_glow_scroll.dart';

List<Widget> AddIngredientContent(context, {nameController, amountController}) {
  return [
    MingleTextInput(
      label: "Nome",
      icon: Icon(Icons.fastfood),
      controller: nameController,
    ),
    MingleTextInput(
      label: "Quantidade",
      icon: Icon(Icons.trending_up),
      keyboardType: TextInputType.numberWithOptions(),
      controller: amountController,
    ),
    MingleDropdownButton(
      label: "Unidade",
      icon: Icons.local_drink,
    ),
  ];
}

class AddIngredientPage extends StatelessWidget {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: "Adicionar ingrediente",
      hideActionBar: true,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ScrollConfiguration(
                behavior: NoGlowScroll(),
                child: ListView(
                  children: AddIngredientContent(
                    context,
                    nameController: _nameController,
                    amountController: _amountController,
                  ),
                ),
              ),
            ),
          ),
          MingleLargeButton(label: "Adicionar", onClick: () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
