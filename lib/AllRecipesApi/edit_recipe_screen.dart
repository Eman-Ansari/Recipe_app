import 'package:dbproject/app.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'recipe.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  EditRecipeScreen({required this.recipe});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final DBHelper dbHelper = DBHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _servingSizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.recipe.name;
    _descriptionController.text = widget.recipe.description;
    _instructionsController.text = widget.recipe.instructions;
    _cookingTimeController.text = widget.recipe.cookingTime.toString();
    _servingSizeController.text = widget.recipe.servingSize.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          // Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.4, // Adjust the opacity as needed
              child: Image.asset(
                'images/8.jpg', // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form fields
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _instructionsController,
                  decoration: InputDecoration(labelText: 'Instructions'),
                ),
                TextField(
                  controller: _cookingTimeController,
                  decoration:
                      InputDecoration(labelText: 'Cooking Time (minutes)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _servingSizeController,
                  decoration: InputDecoration(labelText: 'Serving Size'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _updateRecipe,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save),
                      Text('  Save'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    elevation: 5.0,
                    shadowColor: Color.fromARGB(255, 121, 73, 73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateRecipe() async {
    final updatedRecipe = Recipe(
      id: widget.recipe.id,
      name: _nameController.text,
      description: _descriptionController.text,
      instructions: _instructionsController.text,
      cookingTime: int.parse(_cookingTimeController.text),
      servingSize: int.parse(_servingSizeController.text),
    );
    await dbHelper.updateRecipe(updatedRecipe);
    Navigator.pop(context);
  }
}
