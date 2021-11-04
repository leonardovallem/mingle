class Recipe {
  String? id;
  String name;
  String publisher;
  String? photo;
  int ratings;
  double averageRating;

  Recipe({
    this.id,
    required this.name,
    required this.publisher,
    this.photo,
    this.ratings = 0,
    required this.averageRating,
  });

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "publisher": publisher,
        "photo": photo,
        "ratings": ratings,
        "average_rating": averageRating
      };

  static Recipe fromMap(Map<String, dynamic> recipe) => Recipe(
        id: recipe["_id"],
        name: recipe["name"],
        publisher: recipe["publisher"],
        photo: recipe["photo"],
        ratings: recipe["ratings"],
        averageRating: recipe["average_rating"],
      );
}
