import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
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
  Future future = IngredientAPI.fetchAllNotFromCurrentUser();
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
              icon: const Icon(Icons.search),
              maxLines: 1,
              onSubmitted: (value) {
                setState(() {
                  search = value;

                  if (value.isEmpty) {
                    future = IngredientAPI.fetchAllNotFromCurrentUser();
                    return;
                  }

                  future = IngredientAPI.fetchByName(value);
                });
              },
            ),
            //  CheckboxListButton(
            //   quantity: _selected,
            //   matchingLabel: "ingredientes selecionados",
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => CheckboxList(
            //                 title: "Selecionados",
            //                 items: widget.controller.items,
            //                 controller: widget.controller,
            //                 update: () => setState(() => _selected = widget.controller.items.length),
            //               )),
            //     );
            //   },
            // ),
            Expanded(
              child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<IngredientDTO> fetchedIngredients = snapshot.data as List<IngredientDTO>;
                      List<IngredientDTO> shownIngredients = sortIngredients(fetchedIngredients);

                      if (fetchedIngredients.isNotEmpty) {
                        return ListView.builder(
                            itemCount: shownIngredients.length,
                            itemBuilder: (context, position) => Card(
                                  child: CheckboxListItem(
                                      title: shownIngredients[position].name,
                                      value: widget.controller.items.any((element) => element == shownIngredients[position]),
                                      onChanged: (value) {
                                        setState(() => shownIngredients = sortIngredients(fetchedIngredients));
                                        bool contains = widget.controller.items.any((value) => shownIngredients[position] == value);

                                        if (contains && value) return;
                                        if (!contains && !value) return;

                                        if (value)
                                          widget.controller.items.add(shownIngredients[position]);
                                        else
                                          widget.controller.items.remove(shownIngredients[position]);
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
                                      icon: const Icon(Icons.add),
                                      onClick: () => Navigator.pushNamed(context, "/add/ingredient"),
                                    ),
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

  List<IngredientDTO> sortIngredients(List<IngredientDTO> fetchedIngredients) {
    List<IngredientDTO> shownIngredients = fetchedIngredients.where((ing) => widget.controller.items.contains(ing)).toList();
    shownIngredients.addAll(fetchedIngredients.where((ing) => !widget.controller.items.contains(ing)).toList());
    return shownIngredients;
  }
}
