import 'package:flutter/material.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/pages/edit_recipe_form.dart';


class CustomDialog extends StatelessWidget {

  final String title, description, buttonText;

  final Image image;


  CustomDialog({this.title, this.description, this.buttonText, this.image});


  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),

      ),

      elevation: 0,

      backgroundColor: Colors.transparent,

      child: dialogContent(context),


    );
  }

  dialogContent(BuildContext context) {
    return Stack(

      children: <Widget>[

        Container(

            padding: EdgeInsets.only(

                top: 100,

                bottom: 16,

                left: 16,

                right: 16

            ),

            margin: EdgeInsets.only(top: 16),

            decoration: BoxDecoration(

                color: Colors.white,

                shape: BoxShape.rectangle,

                borderRadius: BorderRadius.circular(17),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black26,

                    blurRadius: 10.0,

                    offset: Offset(0.0, 10.0),

                  )

                ]

            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: <Widget>[

                Text(

                  title,

                  style: TextStyle(

                    fontSize: 24.0,

                    fontWeight: FontWeight.w700,
                    color: Colors.blue[500]

                  ),

                ),

                SizedBox(height: 24.0),

                Text(description, style: TextStyle(fontSize: 16)),

                SizedBox(height: 24.0),

                Align(

                  alignment: Alignment.bottomRight,

                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: BorderSide(color: Colors.orange)
                    ),
                    onPressed: () {
                      Navigator.pop(context);


                    },

                    child: Text(buttonText),
                    color: Colors.orange,


                  ),

                )


              ],

            )

        ),

        Positioned(

            top: 0,

            left: 16,

            right: 16,

            child: CircleAvatar(

              backgroundColor: Colors.blueAccent,

              radius: 30,

              child: ClipOval(

                child: image,

              ),


            )

        )
      ],

    );
  }
}

class RecipeCardRow extends StatefulWidget {
  Recipe  recipe;
  RecipeCardRow(this.recipe);

  @override
  _RecipeCardRowState createState() => _RecipeCardRowState();
}

class _RecipeCardRowState extends State<RecipeCardRow> {
  Widget recipeCard(Recipe recipe){

    return Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(recipe.name,style:
            TextStyle(color: Colors.white,
            fontSize: 25,


            ),),


          ],
        ),
      ),
    );
  }

Widget getRecipeThumb(String image){
  if (image.length >3) {
    return CircleAvatar(

      backgroundColor: Colors.blueAccent,

      radius: 45,

      child: ClipOval(

        child: Image.network(image),

      ),


    );
  }
  else{

    return CircleAvatar(

      backgroundColor: Colors.blueAccent,

      radius: 45,

      child: ClipOval(

        child: Image.asset('images/no_image.jpg'),


      ),


    );
  }

}

  @override
  Widget build(BuildContext context) {

  void showRecipe(Recipe recipe){
    showModalBottomSheet(context: context,
        isScrollControlled: true,




        builder: (context){
      return EditRecipeForm(recipe);

    });


  }
  return Container(
              height: 120,
        margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0),

      child: Stack(
        children: <Widget>[
          GestureDetector(
              onTap: (){
                showRecipe(widget.recipe);
              },
              child: recipeCard(widget.recipe)),
          getRecipeThumb(widget.recipe.image),

        ],
      ),
        );
  }
}

