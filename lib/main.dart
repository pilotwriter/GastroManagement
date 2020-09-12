import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/add_todo_list.dart';
import 'package:to_do_list/pages/reset_password.dart';
import 'package:to_do_list/pages/see_recipe.dart';
import 'package:to_do_list/pages/todolist.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/pages/wrapper.dart';
import 'package:to_do_list/pages/add_recipe_page.dart';
import 'package:to_do_list/pages/recipe_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        routes: {
          '/add_list_item':(context) => addToDoList(),
          '/add__recipe':(context)=>AddRecipe(),
          '/show_recipe':(context)=>ShowRecipe(),
          '/reset_password':(context)=>ResetPassword(),
          'recipe_page':(context)=>RecipePage(),


        },
        home:Wrapper(
        ),

      ),
    );
  }
}
