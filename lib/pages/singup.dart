import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/pages/loading.dart';
class SingUp extends StatefulWidget {
  final Function toggleView;
  SingUp({this.toggleView});
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  AuthServices _auth = AuthServices();
  final _formkey = GlobalKey<FormState>();
  String email ;
  String password;
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
        backgroundColor: Color.fromRGBO(61, 81, 110, 1.0),

        appBar: AppBar(
        backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),
        elevation: 0.0,
        title: Text('Sing Up'),
        actions: <Widget>[
          FlatButton(
            child:Text('Login',
            style:TextStyle(
                color: Colors.white,
                fontSize: 16
            ),),
            color:Color.fromRGBO(66, 67, 92,1.0),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],

      ),
      body:Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image:NetworkImage('https://s.yimg.com/ny/api/res/1.2/n7iCP7kYXn1v4jlcDvx_oA--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-images/2020-03/65acc1d0-62fd-11ea-b37d-549327201816'),
//            fit:BoxFit.cover
//          )
//        ),
        padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
        child: Form(
          key:_formkey,
          child: Column(
            children: <Widget>[

              TextFormField(
                decoration: InputDecoration(
                  hintText:'Email',
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
                validator: (val)=> val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });


                },

              ),
              SizedBox(height: 25,),
              TextFormField(
                decoration: InputDecoration(
                  hintText:'Password',
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
                validator: (val)=> val.length < 6 ? 'Enter your password' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,


              ),
              SizedBox(height: 25,),
              RaisedButton(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                   // side: BorderSide(color: Colors.orange)
                ),
                child: Text('Register'),
                color:Color.fromRGBO(233 , 217, 108, 1),
                onPressed: () async {
                  if(_formkey.currentState.validate()){
                  setState(() {
                    loading=true;
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      loading=false;
                      error ='Please supply valid datas';
                    });

                  }

                }
                else{
                  print('not valid form');
                }

                },
              )

            ],
          ),

        ),
      )

    );
  }
}
