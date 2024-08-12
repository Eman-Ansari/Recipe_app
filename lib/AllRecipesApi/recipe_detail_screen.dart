import 'package:dbproject/app.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.5),
              const Color.fromARGB(255, 82, 52, 6).withOpacity(0.7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'images/7.webp', // Replace 'images/fruit.webp' with your image asset path
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 239, 10, 10)),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white.withOpacity(
                      0.7), // Adjust the opacity of the content container as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Name
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Recipe Name: " + recipe.name,
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(), // Adds a divider between recipe name and description

                      // Recipe Description
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 216, 140, 105),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        recipe.description,
                        style: TextStyle(
                            fontSize: 16.0, fontStyle: FontStyle.italic),
                      ),
                      Divider(), // Adds a divider between description and instructions

                      // Instructions
                      Text(
                        'Instructions',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        recipe.instructions,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Divider(), // Adds a divider between instructions and cooking time

                      // Cooking Time & Serving Size
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Cooking Time: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            TextSpan(
                              text: '${recipe.cookingTime} minutes',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Divider(),

                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Serving Size ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            TextSpan(
                              text: '${recipe.servingSize}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
