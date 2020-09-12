import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/services/database.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/recipe_list.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:to_do_list/pages/loading.dart';
import 'package:to_do_list/pages/constant.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';


class RecipeList extends StatefulWidget {
  List<Recipe>dataCatcher ;

   RecipeList({ Key key ,this.dataCatcher}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}



class _RecipeListState extends State<RecipeList> {
  List<Recipe>showList = List();

  @override
  void initState() {
    showList = widget.dataCatcher;

    super.initState();
  }

  String searchelement;




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);



    String _image;
    Widget myImage(int index,List<Recipe> recipes)
    {
      if(recipes[index].image == ''){
        return Image.asset('images/no_image.jpg',
        );
      }
      else{
        return

          FadeInImage.assetNetwork(
           // fit: BoxFit.cover,

            placeholder: 'images/loading.webp',
            image: recipes[index].image,
          );
      }

    }

    return StreamBuilder<UserData>(
      stream:DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){


          if(snapshot.hasData) {
            UserData userdata = snapshot.data;

            if (userdata.is_admin == true) {


                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.blue[200], Colors.orange[100]])),
                    child: Scaffold(

                        appBar: AppBar(

                          title: Text('Recipes'),
                          backgroundColor: Colors.transparent,
                          elevation: 0,

                        ),
                        backgroundColor: Colors.transparent,
                        body: Column(
                          children: <Widget>[

                            Material(
                              elevation: 0,
                              color: Colors.transparent,
                              child: TextField(


                                onChanged: (val) {

                           val = val.toLowerCase();
                           setState(() {
                             searchelement = val;
                             showList = widget.dataCatcher.where((element) {
                                 var name = element.name.toLowerCase();
                                 return name.contains(searchelement);


                                 }).toList();
                           });

                           },

                                decoration: InputDecoration(
                                    labelText: "Search",
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)))),
                              ),),
                            SizedBox(height: 15,),
                            Expanded(
                                child: ListView.builder(

                                  shrinkWrap: true,
                                  itemCount: showList.length,




                                  itemBuilder: (context, index) {




                                    if (showList[index].image == null) {
                                      String _image = 'images/new.png';
                                    }
                                    else {
                                      _image = showList[index].image;
                                    }
                                    //   print(recipes[index].image);

                                    return Column(
                                      children: <Widget>[
                                    /*    SlimyCard(
                                          color: Colors.teal[200],
                                          width: 300,
                                          topCardHeight: 350,
                                          bottomCardHeight: 300,
                                          borderRadius: 15,
                                          topCardWidget: Column(
                                            children: <Widget>[
                                              Text(showList[index].name[0]
                                                  .toUpperCase() +
                                                  showList[index].name.substring(1),
                                                style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),),

                                              ClipRRect(borderRadius: BorderRadius
                                                  .circular(25.0),


                                                  child: myImage(index,showList)


                                              ),
                                              // Image.network('https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/chorizo-mozarella-gnocchi-bake-cropped.jpg')),

                                            ],
                                          ),
                                          bottomCardWidget: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                Text('Ingredients',
                                                  style: TextStyle(

                                                      fontSize: 25,
                                                      color: Colors.white
                                                  ),),
                                                SizedBox(height: 5,),
                                                Text(showList[index].ingredients,
                                                  style: TextStyle(
                                                      fontSize: 16
                                                  ),),
                                                SizedBox(height: 20,),

                                                Text('Recipe',
                                                  style: TextStyle(
                                                      fontSize: 25
                                                      ,
                                                      color: Colors.white
                                                  ),),
                                                SizedBox(height: 5,),

                                                Text(showList[index].recipe,
                                                  style: TextStyle(
                                                      fontSize: 16
                                                  ),),
                                                RaisedButton(


                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(7.0),
                                                    //side: BorderSide(color: Colors.orange)
                                                  ),
                                                  color: Color.fromRGBO(
                                                      233, 217, 108, 1),
                                                  onPressed: () async {
                                                    final CollectionReference recipecollection = Firestore
                                                        .instance.collection(
                                                        'recipe');
                                                    await recipecollection.document(
                                                        showList[index].id).delete();
                                                    StorageReference firestoreStorageref = await FirebaseStorage
                                                        .instance
                                                        .getReferenceFromUrl(
                                                        showList[index].image);
                                                    firestoreStorageref.delete();
                                                  },

                                                  child: Text(
                                                      'Delete'
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                          slimeEnabled: false,
                                        ),*/


                            /*          Container(
                                        width: 400,

                                        child: Card(
                                          child:Column(
                                            children: <Widget>[
                                              ExpansionTile(
                                                leading: myImage(index,showList),
                                                title: Text(showList[index].name[0]
                                                    .toUpperCase() +
                                                    showList[index].name.substring(1),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                          children: <Widget>[
                                              Column(
                                              children: <Widget>[
                                                SizedBox(height: 10,),
                                                Text('Ingredients',
                                                style: TextStyle(

                                                    fontSize: 25,
                                                    color: Colors.brown
                                                ),),
                                              SizedBox(height: 5,),
                                              Text(showList[index].ingredients,
                                                style: TextStyle(
                                                    fontSize:16
                                                ),),
                                              SizedBox(height: 20,),

                                              Text('Recipe',
                                                style: TextStyle(
                                                    fontSize: 25
                                                    ,
                                                    color: Colors.brown
                                                ),),
                                              SizedBox(height: 5,),

                                              Text(showList[index].recipe,
                                                style: TextStyle(
                                                    fontSize: 16
                                                ),),

                                            ],
                                          ),


                                                          ],

                                              )
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(

                                            borderRadius: BorderRadius.circular(15.0),

                                          ),
                                        ),
                                      ),*/
                                      RecipeCardRow(showList[index]),

                                        SizedBox(height: 5,)
                                      ],
                                    );
                                  },

                                )),
                          ],
                        )

                    ),
                  );


            }


        else{
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue[200], Colors.orange[100]])),
                child: Scaffold(
                    appBar: AppBar(

                      title: Text('Recipes'),
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                    ),
                    backgroundColor: Colors.transparent,
                    body: Column(
                      children: <Widget>[

                        Material(
                          elevation: 0,
                          color: Colors.transparent,
                          child: TextField(


                            onChanged: (val) {

                              val = val.toLowerCase();
                              setState(() {
                                searchelement = val;
                                showList = widget.dataCatcher.where((element) {
                                  var name = element.name.toLowerCase();
                                  return name.contains(searchelement);


                                }).toList();
                              });

                            },

                            decoration: InputDecoration(
                                labelText: "Search",
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ),),
                        SizedBox(height: 15,),
                        Expanded(
                            child: ListView.builder(

                              shrinkWrap: true,
                              itemCount: showList.length,




                              itemBuilder: (context, index) {




                                if (showList[index].image == null) {
                                  String _image = 'images/new.png';
                                }
                                else {
                                  _image = showList[index].image;
                                }
                                //   print(recipes[index].image);

                                return Column(
                                  children: <Widget>[
                                    SlimyCard(
                                      color: Colors.teal[200],
                                      width: 300,
                                      topCardHeight: 350,
                                      bottomCardHeight: 300,
                                      borderRadius: 15,
                                      topCardWidget: Column(
                                        children: <Widget>[
                                          Text(showList[index].name[0]
                                              .toUpperCase() +
                                              showList[index].name.substring(1),
                                            style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),),

                                          ClipRRect(borderRadius: BorderRadius
                                              .circular(25.0),


                                              child: myImage(index,showList)


                                          ),
                                          // Image.network('https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/chorizo-mozarella-gnocchi-bake-cropped.jpg')),

                                        ],
                                      ),
                                      bottomCardWidget: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Text('Ingredients',
                                              style: TextStyle(

                                                  fontSize: 25,
                                                  color: Colors.white
                                              ),),
                                            SizedBox(height: 5,),
                                            Text(showList[index].ingredients,
                                              style: TextStyle(
                                                  fontSize: 16
                                              ),),
                                            SizedBox(height: 20,),

                                            Text('Recipe',
                                              style: TextStyle(
                                                  fontSize: 25
                                                  ,
                                                  color: Colors.white
                                              ),),
                                            SizedBox(height: 5,),

                                            Text(showList[index].recipe,
                                              style: TextStyle(
                                                  fontSize: 16
                                              ),),


                                          ],
                                        ),
                                      ),
                                      slimeEnabled: false,
                                    ),
                                    SizedBox(height: 25,)
                                  ],
                                );
                              },

                            )),
                      ],
                    )

                ),
              );

        }
          }
else{
  return Text('olmadı Yüzbaşı');
          }

      }
    );



/*
      Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[200], Colors.orange[100]])),
      child: Scaffold(
        appBar: AppBar(
          title:Text('Recipes'),
              backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        backgroundColor: Colors.transparent,
        body: ListView.builder(

          itemCount:recipes.length,

          itemBuilder: (context,index){
            if(recipes[index].image == null){
              String _image = 'images/new.png';
            }
            else{
              _image = recipes[index].image;
            }
            print(recipes[index].image);

            return  Column(
              children: <Widget>[
                SlimyCard(
                  color: Colors.teal[200],
                  width: 300,
                  topCardHeight: 350,
                  bottomCardHeight: 300,
                  borderRadius: 15,
                  topCardWidget: Column(
                    children: <Widget>[
                      Text(recipes[index].name[0].toUpperCase()+recipes[index].name.substring(1),
                      style: TextStyle(
                        fontSize:35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),

                      ClipRRect(   borderRadius: BorderRadius.circular(25.0),


                            child: myImage(index)




                            ),
                            // Image.network('https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/chorizo-mozarella-gnocchi-bake-cropped.jpg')),

                    ],
                  ),
                  bottomCardWidget: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text('Ingredients',
                        style: TextStyle(

                          fontSize: 25,
                          color: Colors.white
                        ),),
                        SizedBox(height: 5,),
                        Text(recipes[index].ingredients,
                        style: TextStyle(
                          fontSize:16
                        ),),
                        SizedBox(height: 20,),

                        Text('Recipe',
                        style: TextStyle(
                          fontSize: 25
                              ,
                          color: Colors.white
                        ),),
                        SizedBox(height: 5,),

                        Text(recipes[index].recipe,
                        style: TextStyle(
                          fontSize: 16
                        ),),

                      ],
                    ),
                  ),
                  slimeEnabled: false,
                ),
                SizedBox(height: 25,)
              ],
            );
          },

        ),
      ),
    );*/
  }
}
