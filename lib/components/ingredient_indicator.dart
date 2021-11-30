import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/model/used_ingredient.dart';

class IngredientIndicator extends StatelessWidget {
  UsedIngredient usedIngredient;

  IngredientIndicator(this.usedIngredient);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(10),
              child: Text(
                usedIngredient.ingredient,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "${usedIngredient.amount}${usedIngredient.measurementUnit}",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
