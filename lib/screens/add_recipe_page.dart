import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/components/checkbox_list.dart';
import 'package:projects/components/checkbox_list_button.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/dao/user_dao.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/model/dto/used_ingredient_dto.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/networking/firebase.dart';
import 'package:projects/util/list_items_controller.dart';
import 'package:projects/util/no_glow_scroll.dart';

class AddRecipePage extends StatefulWidget {
  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final ListItemsController _preparationController = ListItemsController<String>();
  final ListItemsController _ingredientsController = ListItemsController<IngredientDTO>();
  final ListItemsController _searchedIngredientsController = ListItemsController<IngredientDTO>();

  String? _file;
  String _displayMessage = "escolher imagem";

  @override
  Widget build(BuildContext context) {
    List<IngredientDTO> usedIngredients = [];
    usedIngredients.addAll(_ingredientsController.items.cast<IngredientDTO>());
    usedIngredients.addAll(_searchedIngredientsController.items.cast<IngredientDTO>());

    void addRecipe() async {
      var recipe = RecipeDTO(
        name: _nameController.text,
        usedIngredients: usedIngredients.map((ing) => UsedIngredientDTO(ingredient: ing)).toList(),
        preparation: _preparationController.items.cast<String>(),
        creatorId: await currentUsername(),
        picture: _file,
      );
      await RecipeAPI.insert(recipe);
      Navigator.pop(context);
    }

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
              future: IngredientAPI.fetchFromCurrentUser(),
              builder: (context, snapshot) {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.35),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: Offset(0, 3),
                        )
                      ]),
                      child: ElevatedButton(
                        onPressed: () async {
                          final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (file == null) return;

                          setState(() => _displayMessage = "carregando imagem...");
                          _file = await uploadImage(file);

                          setState(() => _displayMessage = "imagem selecionada");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(Icons.image, color: Colors.black54),
                            ),
                            Text(_displayMessage,
                                style: const TextStyle(color: Color(0xDDAB7979), fontSize: 16, fontWeight: FontWeight.w400))
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                            primary: Color(0xFFFAFAFA),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                      ),
                    ),
                    MingleTextInput(
                      label: "nome",
                      icon: Icon(Icons.fastfood),
                      controller: _nameController,
                    ),
                    CheckboxListButton(
                      quantity: _ingredientsController.items.length,
                      matchingLabel: "ingredientes selecionados",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CheckboxList(
                              title: "Ingredientes",
                              items: snapshot.data as List<IngredientDTO>,
                              controller: _ingredientsController,
                              searchedItemsController: _searchedIngredientsController,
                              update: () => setState(() {}),
                            );
                          }),
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
          MingleLargeButton(label: "adicionar", onClick: () => addRecipe())
        ],
      ),
    );
  }
}
