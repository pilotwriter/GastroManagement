import 'package:flutter/material.dart';
import 'package:to_do_list/pages/signin.dart';
import 'package:to_do_list/pages/singup.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleView(){
    setState(() {
      showsignin = !showsignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showsignin ==true){
      return SignIn(toggleView:toggleView);    }
    else{
      return SingUp(toggleView:toggleView);
    }
  }
}
