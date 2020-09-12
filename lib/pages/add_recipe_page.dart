import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/services/database.dart';
import 'package:to_do_list/models/user.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/constant.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:to_do_list/pages/loading.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formkey = GlobalKey<FormState>();
  String recipe ='';
  String name ='';
  String ingredients ='';
  File _image;
  bool _loading = false;
  final picker = ImagePicker();
  bool _is_image = false;
  @override
  Widget build(BuildContext context) {

    Future getImage()async{
      final picked_file  = await picker.getImage(source: ImageSource.camera);
      File cropped = await ImageCropper.cropImage(sourcePath: picked_file.path,compressQuality: 70,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,

      ]);


      setState(() {
        _image= File(cropped.path);
        _is_image = true;
      });
    }

      Future uploadImage (BuildContext context) async{
      String _fileName=basename(_image.path);
      StorageReference fireStoreStorageRef = FirebaseStorage.instance.ref().child(_fileName);
      StorageUploadTask uploadTask = fireStoreStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
    }

    final user = Provider.of<User>(context);
    return _loading ? Loading() : Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[200], Colors.orange[100]])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppBar(
          title: Text('Add recipe'),
        ),
        body: SingleChildScrollView(
          child: Column(
                        children: <Widget>[

                          Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(35, 50, 35, 0),
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(

                                        onChanged: (val){
                                          setState(() {
                                            name =val;
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
                                      SizedBox(height: 25,),

                                      TextFormField(
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
                                      SizedBox(height: 25,),

                                      TextFormField(
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Please fill the fields';
                                          }
                                          return null;
                                        },
                                        onChanged: (val){
                                          setState(() {
                                            recipe=val;
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Click to add an image ',
                                          style: TextStyle(
                                            fontSize: 18
                                          ),),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: (){
                                              getImage();

                                            },
                                          ),

                                        ],
                                      ),
                                      Center(
                                        child:  RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              side: BorderSide(color: Colors.orange)
                                          ),
                                          color: Colors.orange,
                                          onPressed:()async {
                                            if(_formkey.currentState.validate()){
                                              setState(() {
                                                _loading=true;
                                              });


                                            if(_is_image == true){
                                              await uploadImage(context);
                                            final ref = FirebaseStorage.instance.ref().child(basename(_image.path));
                                            var url = await ref.getDownloadURL();
                                            print(url);
                                            await DatabaseService(uid:user.uid).updateRecipe(name, recipe, ingredients,url);

                                            setState(() {
                                              _loading=false;
                                            });
                                            showDialog(context: context,builder: (context)=> CustomDialog(title: 'Success!',description: 'You have  successfully created a new recipe!',buttonText: 'Confirm',image: Image.network('https://media0.giphy.com/media/6PopYBwOlKS8o/giphy.gif?cid=ecf05e47fvlrd92cp7bw440behj6ygjieez8ppowocgpdlii&rid=giphy.gif'))) ;

                                            _formkey.currentState.reset();}
                                            else{
                                              await DatabaseService(uid:user.uid).updateRecipe(name, recipe, ingredients,'');
                                              setState(() {
                                                _loading=false;
                                              });

                                              showDialog(context: context,builder: (context)=> CustomDialog(title: 'Success!',description: 'You have  successfully created a new recipe!',buttonText: 'Confirm',image: Image.network('https://media0.giphy.com/media/6PopYBwOlKS8o/giphy.gif?cid=ecf05e47fvlrd92cp7bw440behj6ygjieez8ppowocgpdlii&rid=giphy.gif'))) ;


                                            }
                                            }


                                          },
                                          child: Text(
                                              'Save'
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),

                          ),



                        ],
          ),
        ),
      ),
    );
  }
}
