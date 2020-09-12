import 'package:flutter/material.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/pages/constant.dart';
import 'package:to_do_list/services/database.dart';
import 'package:provider/provider.dart';


class EditRecipeForm extends StatefulWidget {
  Recipe recipe;


  EditRecipeForm(this.recipe);

  @override
  _EditRecipeFormState createState() => _EditRecipeFormState();
}

class _EditRecipeFormState extends State<EditRecipeForm> {
  final formkey = GlobalKey<FormState>();
  String name;
  String ingredients;
  String recipeText;
  @override
  void initState() {
    // TODO: implement initState
   name =widget.recipe.name;
  ingredients = widget.recipe.ingredients;
  recipeText =widget.recipe.recipe;
  super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SingleChildScrollView(



          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Name',style: TextStyle(
                  fontSize:25,
                  fontWeight:FontWeight.bold
                ),),


                 TextFormField(

                    initialValue: widget.recipe.name,

                    onChanged: (val){
                      setState(() {
                        name=val;
                      });
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please fill the fields';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText: 'Name of Recipe',
                        fillColor: Colors.white,
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(

                            )
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines:null,


                  ),

                Text('Ingredients',style: TextStyle(
                    fontSize:25,
                    fontWeight:FontWeight.bold
                ),),
                TextFormField(
                    initialValue: widget.recipe.ingredients,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please fill the fields';
                      }
                      return null;
                    },
                    onChanged: (val){
                      setState(() {
                       ingredients=val;
                      });
                    },

                    decoration: InputDecoration(
                        hintText: 'Ingredients',
                        fillColor: Colors.white,
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(

                            )
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines:null,


                  ),

                Text('Recipe',style: TextStyle(
                    fontSize:25,
                    fontWeight:FontWeight.bold
                ),),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    initialValue: widget.recipe.recipe,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please fill the fields';
                      }
                      return null;
                    },
                    onChanged: (val){
                      setState(() {
                        recipeText=val;
                      });
                    },

                    decoration: InputDecoration(
                        hintText: 'Recipe',
                        fillColor: Colors.white,
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(

                            )
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines:null,


                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: BorderSide(color: Colors.orange)
                  ),
                  color: Colors.orange,
                  onPressed:()async {
                    print(recipeText);
                    if(formkey.currentState.validate()){

                      await DatabaseService(uid:user.uid).updateRecipeItem(name, recipeText, ingredients,widget.recipe);
                      Navigator.pop(context);
                        showDialog(context: context,builder: (context)=> CustomDialog(title: 'Success!',description: 'You have  successfully created a new recipe!',buttonText: 'Confirm',image: Image.network('https://media0.giphy.com/media/6PopYBwOlKS8o/giphy.gif?cid=ecf05e47fvlrd92cp7bw440behj6ygjieez8ppowocgpdlii&rid=giphy.gif'))) ;



                    }


                  },
                  child: Text(
                      'Save'
                  ),
                )


              ],
            ),
          ),


    );
  }
}
