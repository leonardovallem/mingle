import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/checkbox_list.dart';
import 'package:projects/components/checkbox_list_button.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/dao/ingredients_dao.dart';
import 'package:projects/model/ingredient.dart';
import 'package:projects/util/list_items_controller.dart';
import 'package:projects/util/no_glow_scroll.dart';

class AddRecipePage extends StatefulWidget {
  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final ListItemsController _preparationController = ListItemsController();
  final ListItemsController _ingredientsController = ListItemsController();

  @override
  Widget build(BuildContext context) {
    List<String> _preparation = [];

    return MingleScaffold(
      title: "Adicionar receita",
      hideActionBar: true,
      body: Column(
        children: [
          Expanded(
              child: ScrollConfiguration(
            behavior: NoGlowScroll(),
            child: FutureBuilder(
              future: savedIngredients(),
              builder: (context, snapshot) {
                return ListView(
                  children: [
                    MingleTextInput(
                      label: "Nome",
                      icon: Icon(Icons.fastfood),
                      controller: _nameController,
                    ),
                    CheckboxListButton(
                      quantity: _ingredientsController.items.length,
                      matchingLabel: "ingredientes selecionados",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckboxList(
                                    title: "Ingredientes",
                                    items: snapshot.data as List<Ingredient>,
                                    controller: _ingredientsController,
                                    update: () => setState(() {}),
                                  )),
                        );
                      },
                    ),
                    CheckboxListButton(
                      quantity: _preparationController.items.length,
                      matchingLabel: "passos de preparação",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckboxList(
                                    title: "Preparação",
                                    addLabel: "Etapa da preparação",
                                    items: _preparation,
                                    canAdd: true,
                                    controller: _preparationController,
                                    update: () => setState(() {}),
                                  )),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          )),
          MingleLargeButton(label: "adicionar", onClick: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
