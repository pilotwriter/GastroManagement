import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/services/database.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/pages/todolist.dart';


class ShowTodoList extends StatefulWidget {
  @override
  _ShowTodoListState createState() => _ShowTodoListState();
}

class _ShowTodoListState extends State<ShowTodoList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Todo>>.value(
      value:DatabaseService().todo,
      child: Scaffold(
        backgroundColor:Color.fromRGBO(188, 196, 220, 1.0),


        body:Container(

          child: ToDoList()),
      ),
    );
  }
}
