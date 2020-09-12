import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import'package:flutter/material.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/services/database.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/recipe_list.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:to_do_list/pages/loading.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final recipes = Provider.of<List<Recipe>>(context);


    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

          Center(
            child:
            ActionChip(
                backgroundColor:Color.fromRGBO(233 , 217, 108, 1),

                label: Text('Add Recipe'),
                onPressed: () {
                Navigator.pushNamed(context, '/add__recipe');
                }
            ),

          ),

            ActionChip(
              backgroundColor: Color.fromRGBO(233 , 217, 108, 1),

                label: Text('See Recipes'),
                onPressed: () {
        //     Navigator.pushNamed(context, '/show_recipe');

             Navigator.push(context,MaterialPageRoute(builder: (context)=>RecipeList(dataCatcher: recipes,)));
                }
            ),

        ],
        ),
      ),
    );
  }
}
