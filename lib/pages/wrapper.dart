import 'package:provider/provider.dart';
import 'package:to_do_list/pages/Authenticate.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/pages/Authenticate.dart';
import 'package:to_do_list/pages/Home.dart';
import 'package:to_do_list/services/database.dart';
import 'package:to_do_list/pages/loading.dart';
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
import 'package:to_do_list/pages/new_recipe_list.dart';




class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

if(user == null){
  return Authenticate();
}

else{

  return StreamBuilder<UserData>(
   stream : DatabaseService(uid:user.uid).userData,
    builder:(context,snapshot){
      UserData userdata = snapshot.data;

      if(snapshot.hasData){
        if(userdata.is_admin == true){

          return StreamProvider<List<Recipe>>.value(
            value: DatabaseService(uid: user.uid).recipe,
            child: MaterialApp(
              routes: {
                '/add_list_item':(context) => addToDoList(),
                '/add__recipe':(context)=>AddRecipe(),
                '/show_recipe':(context)=>ShowRecipe(),
                '/reset_password':(context)=>ResetPassword(),
                'recipe_page':(context)=>RecipePage(),



              },
              home: Home(),
            ),

          );


        }
        else {
          return StreamProvider<List<Recipe>>.value(
            value: DatabaseService(uid: user.uid).recipe,
            child: MaterialApp(
              routes: {
                '/add_list_item':(context) => addToDoList(),
                '/add__recipe':(context)=>AddRecipe(),
                '/show_recipe':(context)=>ShowRecipe(),
                '/reset_password':(context)=>ResetPassword(),
                'recipe_page':(context)=>RecipePage(),




              },
              home: Home(),
            ),

          );

        }



      }
        else{
          return Loading();
      }

    }


    );
}
  }
}
