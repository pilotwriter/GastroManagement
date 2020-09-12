import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/pages/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:to_do_list/pages/constant.dart';
import 'package:email_validator/email_validator.dart';


class ResetPassword extends StatefulWidget {

  final Function toggleView;
  ResetPassword({this.toggleView});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthServices _auth = AuthServices();
  final _formkey = GlobalKey<FormState>();
  String email ;
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
        backgroundColor: Color.fromRGBO(61, 81, 110, 1.0),

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66 , 67, 92, 1.0),
          elevation: 0.0,
          title: Text('Reset Password'),


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

                SizedBox(height: 20,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    //side: BorderSide(color: Color.fromRGBO(207, 81, 48, 1))
                  ),

                  splashColor: Colors.greenAccent,
                  color:Color.fromRGBO(233 , 217, 108, 1),
                  child: Text('Submit',
                    style: TextStyle(

                    ),
                  ),
                  onPressed: () async{
                    if(_formkey.currentState.validate() && EmailValidator.validate(email)){
                    dynamic result = await  _auth.resetPassword(email);





                     showDialog(context: context,builder: (context)=> CustomDialog(title: 'Success!',description: 'Check your email address to reset your password!',buttonText: 'Confirm',image: Image.asset('images/beer.gif'))) ;


                    }
                    else{
                      showDialog(context: context,builder: (context)=> CustomDialog(title: 'Opps!',description: 'Check your  data again please',buttonText: 'Confirm',image: Image.asset('images/error.webp'))) ;



                    }





                  }
,),


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
