

class UsedIngredient {
  String ingredient;
  double amount;
  String measurementUnit;

  UsedIngredient({
    required this.ingredient,
    required this.amount,
    required this.measurementUnit,
  });

  Map<String, dynamic> toMap() => {
        "ingredient": ingredient,
        "amount": amount,
        "measurement_unit": measurementUnit,
      };

  static UsedIngredient fromMap(Map<String, dynamic> usedIngredient) => UsedIngredient(
        ingredient: usedIngredient["ingredient"],
        amount: usedIngredient["amount"],
        measurementUnit: usedIngredient["measurement_unit"],
      );
}
