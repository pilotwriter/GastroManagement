import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/pages/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:to_do_list/pages/constant.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        title: Text('Sing In'),
        actions: <Widget>[
          FlatButton(
            child:Text('Create account',
            style: TextStyle(
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
      body: Container(

        padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Form(
          key: _formkey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              TextFormField(decoration: InputDecoration(
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
              SizedBox(height: 20,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  //side: BorderSide(color: Color.fromRGBO(207, 81, 48, 1))
              ),

                splashColor: Colors.greenAccent,
                color:Color.fromRGBO(233 , 217, 108, 1),
                child: Text('Sign in',
                  style: TextStyle(

                  ),
                ),
                onPressed: () async{
                  //make a backend call to sign_in
                  if(_formkey.currentState.validate()){
                    //if the form is valid
                    setState(() {
                      //show loading page
                      loading=true;

                      //for loading page to show
                    });

                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    //if it is succesfull,it will automaticly direct to main page
                    //because we are keep checking status of user and according to that
                    //routing our user,check main.dart
                    if(result == null){

                      setState(() {
                        loading=false;
                        //değer boşsa loading pageyi göstermesin!
                      });
                      showDialog(context: context,builder: (context)=> CustomDialog(title: 'Opps!',description: 'Check your  data again please',buttonText: 'Confirm',image: Image.asset('images/error.webp'))) ;

                    }

                  }
                  else{
                    print('not valid form');

                  }
                },

              ),
              RichText(
                text: TextSpan(
                  text: 'Forgot Password?',
                  style: TextStyle(
                    color: Colors.yellow
                  ),
                  recognizer: TapGestureRecognizer()..onTap =()=> Navigator.pushNamed(context, '/reset_password'),


                ),
              ),

              Text(error,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.red,

                ),)

            ],
          ),
        ),
      )


    );
  }
}
