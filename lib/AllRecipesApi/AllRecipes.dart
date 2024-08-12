import 'package:dbproject/AllRecipesApi/add_recipe_screen.dart';
import 'package:dbproject/AllRecipesApi/db_helper.dart';
import 'package:dbproject/AllRecipesApi/edit_recipe_screen.dart';
import 'package:dbproject/AllRecipesApi/recipe.dart';
import 'package:dbproject/AllRecipesApi/recipe_detail_screen.dart';
import 'package:dbproject/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this import for GetX

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder<List<Recipe>>(
        future: dbHelper.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final recipes = snapshot.data!;
              print('Recipes fetched: ${recipes.length}');
              return Stack(
                children: [
                  // Background Image with Opacity
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.6, // Adjust the opacity as needed
                      child: Image.asset(
                        'images/8.jpg', // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // List View of Recipes
                  ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      final firstLetter =
                          recipe.name.isNotEmpty ? recipe.name[0] : '';

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: Colors.brown,
                        margin: const EdgeInsets.all(5),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          leading: CircleAvatar(
                            radius: 35,
                            child: Text(
                              firstLetter,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.brown,
                          ),
                          title: Text(
                            recipe.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Click here', // Add a description if needed
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditRecipeScreen(recipe: recipe),
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(recipe.id);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // Floating Action Button at the bottom right
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      backgroundColor:
                          Colors.brown, // Set the color same as app bar
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRecipeScreen()),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ),
                ],
              );
            } else {
              print('No recipes found.');
              return Center(child: Text('No recipes found.'));
            }
          } else {
            print('State: ${snapshot.connectionState}');
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(int? id) {
    if (id == null) return; // Check if id is null

    Get.defaultDialog(
      title: 'Delete Recipe',
      middleText: 'Are you sure you want to delete this recipe?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (id != null) {
          // Double-check if id is not null before proceeding
          _deleteRecipe(id);
        }
        Get.back(); // Close the dialog
      },
    );
  }

  Future<void> _deleteRecipe(int id) async {
    await dbHelper.deleteRecipe(id);
    setState(() {});
  }
}
