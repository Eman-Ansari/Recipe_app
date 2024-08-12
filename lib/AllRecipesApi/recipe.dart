//variables

class Recipe {
  final int? id;
  final String name;
  final String description;
  final String instructions;
  final int cookingTime;
  final int servingSize;
  //constructor of variables

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.cookingTime,
    required this.servingSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructions': instructions,
      'cooking_time': cookingTime,
      'serving_size': servingSize,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      instructions: map['instructions'],
      cookingTime: map['cooking_time'],
      servingSize: map['serving_size'],
    );
  }
}
