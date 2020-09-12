import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:flutter/scheduler.dart';
class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
List<bool> newList = List();
List<String> _myAmazingList =List();

 Widget myRow(String i,List<Todo> todos,int index){
int counter =0;
   for(int j = 0;j<todos.length;j++) {

  for (int i = 0; i < todos[j].todolist.length; i++) {
    counter++;
    if (newList.length < counter) {
      newList.add(false);
      _myAmazingList.add(todos[j].todolist[i]);

    }
    else {
      continue;
    }
  }
}


   return Container(
     decoration: BoxDecoration(
     border: Border.all(
       color: Colors.black,
       width: 1,
     ),
     borderRadius: BorderRadius.circular(8),
   ),



     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
         Flexible(

             child: Text(i)
         ),
         Checkbox(
           //value:_check_box[todos[index].todolist.indexOf(i)],
           value:newList[_myAmazingList.indexOf(i)],

           onChanged: (bool val){
             setState(() {
               //newList[todos[index].todolist.indexOf(i)]  = val;
               newList[_myAmazingList.indexOf(i)]  = val;
             });



           },


         ),
       ],
     ),
   );

 }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final todos = Provider.of<List<Todo>>(context);

    if(todos == null){
      return Center(
        child: Text('nothing to show'),
      );}
      else {
        return ListView.builder(

          itemCount: todos.length,
          itemBuilder:(context,index){


            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Color.fromRGBO(233 , 217, 108, 1),

                    child: Padding(

                      padding: EdgeInsets.only(
                          top: 12.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(todos[index].date,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepOrange[900],
                          letterSpacing: 1,

                        ),),

                        children: <Widget>[


                          //for(var i in todos[index].todolist)
                          for(int i =0; i<todos[index].todolist.length;i++)
                          myRow(todos[index].todolist[i],todos,index),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25,)

                ],
              ),
            );

          });
    }
    }
  }

