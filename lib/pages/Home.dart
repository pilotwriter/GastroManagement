import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/pages/placeholder_widget.dart';
import 'package:to_do_list/pages/profile.dart';
import 'package:to_do_list/pages/add_todo_list.dart';
import 'package:to_do_list/pages/showtodolist.dart';
import 'package:to_do_list/pages/recipe_page.dart';
class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentindex =0;
  List<Widget> navlist =[
    addToDoList(),
    ShowTodoList(),
    Profile(),
    RecipePage(),



  ];

  @override
  Widget build(BuildContext context) {
    AuthServices _auth = AuthServices();
    return Scaffold(
      body:navlist[_currentindex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,

        currentIndex: _currentindex,
        onTap: (index){
         setState(() {
           _currentindex=index;
         });
        },
        items:[
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle,),
            title: new Text('Add'),
              backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.remove_red_eye),
            title: new Text('See the lists'),
              backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor:Color.fromRGBO(66 , 67, 92, 1.0),


          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.fastfood),
            title: Text('Recipe'),
              backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),

          ),

        ],
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),
        elevation: 0,
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
            //    side: BorderSide(color: Colors.orange)
            ),
            onPressed: (){
              _auth.signOut();

            },
            color:Color.fromRGBO(66 , 67, 92, 1.0),
            child: Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
          )
        ],
      ),

    );
  }
}
