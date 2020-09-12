import'package:flutter/material.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/services/database.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/recipe_list.dart';
class ShowRecipe extends StatefulWidget {
  @override
  _ShowRecipeState createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);

    return StreamProvider<List<Recipe>>.value(

        value: DatabaseService().recipe,
        child:RecipeList(),


    );
  }
}
