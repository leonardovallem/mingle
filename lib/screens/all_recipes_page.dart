import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/networking/api.dart';
import 'package:projects/util/no_glow_scroll.dart';

import 'recipe_page.dart';

class AllRecipesPage extends StatefulWidget {
  bool search;
  String? searchFor;
  Future? future;

  AllRecipesPage({this.search = false, this.searchFor, this.future})
      : assert((future == null && searchFor == null) || (future == null && searchFor != null) || (future != null && searchFor == null));

  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  @override
  Widget build(BuildContext context) {
    Future fetchRecipes() async {
      if (!widget.search || widget.searchFor == null || widget.searchFor!.isEmpty) return RecipeAPI.fetchAll();
      return RecipeAPI.fetchByName(widget.searchFor!);
    }

    return MingleScaffold(
      title: "Receitas",
      hideActionBar: true,
      body: SafeArea(
        child: Column(
          children: [
            if (widget.search)
              MingleTextInput(
                  label: "Pesquisar",
                  icon: Icon(Icons.search),
                  onSubmitted: (value) => setState(() {
                        widget.searchFor = value;
                      })),
            Expanded(
              child: FutureBuilder(
                future: widget.future ?? fetchRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<RecipeDTO> fetchedRecipes = snapshot.data as List<RecipeDTO>;

                    return ScrollConfiguration(
                      behavior: NoGlowScroll(),
                      child: ListView.builder(
                        itemCount: fetchedRecipes.length,
                        itemBuilder: (context, position) => Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.35),
                              spreadRadius: 0.5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ]),
                          margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          padding: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height * 0.125,
                          child: InkWell(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(fetchedRecipes[position]))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    fetchedRecipes[position].picture ??
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2bXeJvIwzAID0OWX097nzXmEtiBWLKUH7Fg&usqp=CAU",
                                    fit: BoxFit.contain,
                                    width: MediaQuery.of(context).size.height * 0.1,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Spacer(),
                                    Text(fetchedRecipes[position].name ?? "", style: const TextStyle(fontSize: 20)),
                                    Spacer(),
                                    Text(fetchedRecipes[position].creatorId ?? "Usuário desconhecido"),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
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
                        children: [
                          LayoutBuilder(builder: (context, constraints) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.warning,
                                size: constraints.biggest.width - 8,
                                color: Colors.black38,
                              ),
                            );
                          }),
                          const Text(
                            "Algum erro ocorreu",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 32, color: Colors.black38),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
