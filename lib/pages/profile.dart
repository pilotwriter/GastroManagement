import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/recipe.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/services/database.dart';
import 'package:to_do_list/pages/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final recipes = Provider.of<List<Recipe>>(context);
    return StreamBuilder<UserData>(

      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        UserData userdata  = snapshot.data;
       if(snapshot.hasData){ return
         Container(
           decoration: BoxDecoration(
             color: Color.fromRGBO(188, 196, 220, 1.0),

         ),
          padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
          child: Form(


            child: Column(
              children: <Widget>[

                TextFormField(
                  initialValue:userdata.name,

                  decoration: InputDecoration(

                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Color.fromRGBO(233 , 217, 108, 1),
                          width: 2,
                        )
                    ),

                  ),
                  onChanged: (val){
                    setState(() {
                      _name = val;
                      print(recipes.length);
                    });
                  },



                ),
                SizedBox(height: 25,),
                RaisedButton(
                  color: Color.fromRGBO(233 , 217, 108, 1),
                  onPressed:()async {

                    await DatabaseService(uid:user.uid).updateUserData(_name,userdata.is_admin);
                  },
                  child: Text(
                      'Save'
                  ),
                )




              ],
            ),



          ),
        );}
       else {

         return Center(
          child:Text('Wait please')
         );
       }
      }
    );
  }
}
