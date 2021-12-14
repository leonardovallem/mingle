import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/model/dto/recipe_dto.dart';
import 'package:projects/screens/recipe_page.dart';

class RecipeVerticalCard extends StatelessWidget {
  RecipeDTO recipe;

  RecipeVerticalCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 3),
            )
          ]),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      recipe.picture ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2bXeJvIwzAID0OWX097nzXmEtiBWLKUH7Fg&usqp=CAU",
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(recipe.name ?? "", style: const TextStyle(fontSize: 24.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(recipe.creatorId ?? "", style: const TextStyle(color: Colors.grey)),
                ),
                if (Toggles.ratingsActive)
                  RatingBarIndicator(
                    itemSize: 32.0,
                    rating: 0,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  )
              ],
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.0)),
          ),
        ),
      ),
    );
  }
}
