import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/services/database.dart';
import 'package:to_do_list/models/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/pages/constant.dart';
class addToDoList extends StatefulWidget {
  @override
  _addToDoListState createState() => _addToDoListState();
}

class _addToDoListState extends State<addToDoList> {


  void incrementTotaltElement(){

    total_element = total_element+1;
    list_items.add('');
  }
   final _formkey = GlobalKey<FormState>();
   int total_element = 1;
   List<String> list_items =['',];
   List<TextEditingController> _controllers= new List();

    void changeFocus(){
      FocusScope.of(context).nextFocus();
    }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor:Color.fromRGBO(188, 196, 220, 1.0),
      floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
        focusColor: Colors.orange,
        onPressed:(){
         setState(() {
           incrementTotaltElement();
         });
        },
      ),
      body:Container(

        padding: EdgeInsets.fromLTRB(25, 60, 25, 0),
        child: Form(
          key:_formkey,
          child: Column(

            children: <Widget>[
              Expanded(
                child: ListView.builder( itemCount: total_element,
            
                  itemBuilder: (context,index){
                  _controllers.add(new TextEditingController());

                     return Column(
                       children: <Widget>[
                         TextFormField(
                           validator: (value){
                             if(value.isEmpty){
                               return 'Please fill the fields';
                             }
                             return null;
                           },
                           decoration: InputDecoration(
                             hintText:'To - do Item',
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
                                   color:Colors.orange[900],
                                   width: 2,
                                 )
                             ),

                           ),
                           controller: _controllers[index],
                           textInputAction: TextInputAction.next,
                           autofocus: true,


                           onChanged: (val){
                            setState(() {

                              list_items[index]= val;

                            });
                           },


                         ),
                         SizedBox(height: 15,)
                       ],
                     );
  },

        ),
              ),
              RaisedButton(


                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    //side: BorderSide(color: Colors.orange)
                ),
                color: Color.fromRGBO(233 , 217, 108, 1),
                onPressed:()async {
                  if(_formkey.currentState.validate()){
                    DateTime now = DateTime.now();
                    String datetime =(now.day.toString()+'/'+now.month.toString()+'/'+now.year.toString());
//                    String formattedDate = DateFormat.yMEd().format(now);
//                  //('yyyy-MM-dd – kk:mm').format(now);

                    await DatabaseService(uid:user.uid).updateTodoData(list_items,datetime);
                    for(int i =0;i<_controllers.length;i++){
                      _controllers[i].clear();




                  }
                    showDialog(context: context,builder: (context)=> CustomDialog(title: 'Success!',description: 'Your To-Do List is successfully created!',buttonText: 'Confirm',image: Image.network('https://media0.giphy.com/media/6PopYBwOlKS8o/giphy.gif?cid=ecf05e47fvlrd92cp7bw440behj6ygjieez8ppowocgpdlii&rid=giphy.gif'))) ;



                  }


                },
                child: Text(
                  'Save'
                ),
              )

            ],
          ),

      )
      )
    );
  }
}
