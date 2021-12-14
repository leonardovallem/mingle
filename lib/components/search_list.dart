import 'package:flutter/material.dart';
import 'package:projects/components/checkbox_list_button.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/model/dto/used_ingredient_dto.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/util/list_items_controller.dart';

import 'checkbox_list.dart';
import 'diamond_button.dart';

class SearchIngredients extends StatefulWidget {
  ListItemsController controller;

  SearchIngredients({required this.controller});

  @override
  State<SearchIngredients> createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  Future future = IngredientAPI.fetchAll();
  String search = "";
  bool showAddButton = true;

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: "Pesquisar",
      hideActionBar: true,
      body: SafeArea(
        child: Column(
          children: [
            MingleTextInput(
              label: "Ingrediente",
              icon: Icon(Icons.search),
              maxLines: 1,
              onSubmitted: (value) {
                setState(() {
                  search = value;

                  if (value.isEmpty) {
                    future = IngredientAPI.fetchAll();
                    return;
                  }

                  future = IngredientAPI.fetchByName(value);
                });
              },
            ),
            CheckboxListButton(
              quantity: widget.controller.items.length,
              matchingLabel: "ingredientes selecionados",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckboxList(
                            title: "Selecionados",
                            items: widget.controller.items,
                            controller: widget.controller,
                            update: () => setState(() {}),
                          )),
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<IngredientDTO> fetchedIngredients = snapshot.data as List<IngredientDTO>;

                      if (fetchedIngredients.isNotEmpty) {
                        return ListView.builder(
                            itemCount: fetchedIngredients.length,
                            itemBuilder: (context, position) => Card(
                                  child: CheckboxListItem(
                                      title: fetchedIngredients[position].name,
                                      value: widget.controller.items.any((element) => element == fetchedIngredients[position]),
                                      onChanged: (value) {
                                        bool contains = widget.controller.items.any((value) => fetchedIngredients[position] == value);

                                        if (contains && value) return;
                                        if (!contains && !value) return;

                                        if (value)
                                          widget.controller.items.add(fetchedIngredients[position]);
                                        else
                                          widget.controller.items.remove(fetchedIngredients[position]);
                                      }),
                                ));
                      }
                    }

                    if (!snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(64.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Nenhum ingrediente encontrado",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 32, color: Colors.black26),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 34.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24.0),
                                    child: Text("Adicionar $search",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.pink,
                                        )),
                                  ),
                                  if (showAddButton)
                                    DiamondButton(
                                        icon: Icon(Icons.add),
                                        onClick: () {
                                          if (search.isEmpty) return;
                                          IngredientAPI.insert(search);
                                          setState(() => showAddButton = false);
                                        }),
                                ],
                              ),
                            )
                          ],
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
