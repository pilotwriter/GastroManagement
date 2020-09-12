import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/pages/signin.dart';
import'package:to_do_list/services/database.dart';
class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  User _userFromFirebaseUser(FirebaseUser user){

    //return User(uid:user.uid);
    return user != null ? User(uid:user.uid) : null;



  }

  Future siggInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      print('başarısız giriş denemesi!');
      return null;
    }
  }

  Future signInWithEmailAndPassword (String email,String password) async{

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
//      List<String> list =["ali","veli",'49','50'];
//      DateTime now =DateTime.now();
//      DateTime date = new DateTime(now.year, now.month, now.day);
//      DatabaseService(uid:user.uid).updateTodoData(list, date);

      return _userFromFirebaseUser(user);


    }
    catch(e){
      print(e.toString());
    }
  }

Future registerWithEmailAndPassword(String email,String password) async{

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      DatabaseService(uid:user.uid).updateUserData('New User',false);
      print(user.uid);

      return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
    }

}



  Stream<User> get user{
  //  return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    return _auth.onAuthStateChanged.map((FirebaseUser user ) => _userFromFirebaseUser(user));

  }


Future signOut()async{
try{
  return await _auth.signOut();
  print('logged out');
}
catch(e){
  print(e.toString());
}
}


Future resetPassword(String email) async{


    try{
return      await _auth.sendPasswordResetEmail(email: email.trim());

    }
    catch(e){
      print(e.toString());
    }

}




}