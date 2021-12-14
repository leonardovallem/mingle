import 'package:flutter/material.dart';
import 'package:projects/components/mingle_dropdown_button.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_snackbar.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/config/authentication.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/dao/owned_ingredients_dao.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/dto/registered_ingredient.dart';
import 'package:projects/model/owned_ingredient.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/util/no_glow_scroll.dart';

List<Widget> AddIngredientContent(context, {nameController, amountController, measurementUnitController}) {
  return [
    MingleTextInput(
      label: "Nome",
      icon: Icon(Icons.fastfood),
      controller: nameController,
    ),
    if(Toggles.partitionedIngredientsActive) MingleTextInput(
      label: "Quantidade",
      icon: Icon(Icons.trending_up),
      keyboardType: TextInputType.numberWithOptions(),
      controller: amountController,
    ),
    if(Toggles.partitionedIngredientsActive) MingleDropdownButton(
      label: "Unidade",
      icon: Icons.local_drink,
      controller: measurementUnitController,
    ),
  ];
}

class AddIngredientPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _measurementUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> insertIntoDatabase(RegisteredIngredientDTO registeredIngredient) async {
      await RegisteredIngredientAPI.insert(registeredIngredient);
      Navigator.pop(context);
    }

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
                    measurementUnitController: _measurementUnitController,
                  ),
                ),
              ),
            ),
          ),
          MingleLargeButton(
              label: "Adicionar",
              onClick: () async {
                FocusScope.of(context).unfocus();

                String? email = await currentUser();
                if(email == null) {
                  ScaffoldMessenger.of(context).showSnackBar(MingleSnackbar(content: Text("Você não está logado")));
                  return;
                }

                var username = (await findUser(email))?.username ?? "Desconhecido";

                OwnedIngredient ingredient = OwnedIngredient(
                  ingredient: _nameController.text,
                  amount: 0.0,//double.parse(_amountController.text),
                  measurementUnit: "", //_measurementUnitController.text,
                  owner: username,
                );
                saveOwnedIngredient(ingredient);

                await insertIntoDatabase(ingredient.toDTO());
              }),
        ],
      ),
    );
  }
}
