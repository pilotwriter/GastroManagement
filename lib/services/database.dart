import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/models/user.dart';
import 'package:to_do_list/models/recipe.dart';

class DatabaseService{
  final CollectionReference todocollection = Firestore.instance.collection('todos');
  final CollectionReference usercollection = Firestore.instance.collection('user');
  final CollectionReference userdatacollection =Firestore.instance.collection('userdata');
  final CollectionReference recipecollection = Firestore.instance.collection('recipe');
  final String uid;
  DatabaseService({this.uid});


  Todo _todoFromFirebaseTode(CollectionReference reference){
    return reference != null ? Todo() : null;
  }


  Future updateTodoData(List<String> todolist, String date) async {

    return await todocollection.document().setData({
       'todolist':todolist,
      'date':date,
      'time_stamp':FieldValue.serverTimestamp(),
    });
  }



  List<Todo> _todoDataFromSnapshot(QuerySnapshot snapshot) {


    return snapshot.documents.map((document){
      List<dynamic> newlist = document.data['todolist'];
      var sList = List<String>.from(newlist);
      return Todo(
          todolist:sList,

          //todolist:document.data['todolist'],
        date:document.data['date']
      );
    }).toList();

  }

  Stream<List<Todo>>get todo{
    return todocollection.orderBy('time_stamp',descending: true).snapshots().map(_todoDataFromSnapshot);
}




  Future updateUserData(String name,bool is_admin) async{

    return await userdatacollection.document(uid).setData({
      'name':name,
      'is_admin':is_admin,




    });

  }
  
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name:snapshot.data['name'],
      is_admin: snapshot.data['is_admin'],
      
      
    );
  }
  
  Stream<UserData>get userData{
    return userdatacollection.document(uid).snapshots().map(_userDataFromSnapshot);

    
  }


Stream<List<Recipe>>get recipe{

    return recipecollection.snapshots().map(_recipeFromSnapshot);
}

  List<Recipe> _recipeFromSnapshot(QuerySnapshot snapshot) {

    return snapshot.documents.map((document){
      return Recipe(
          name :document.data['name'],
          recipe:document.data['recipe'],
          ingredients: document.data['ingredient'],
        image:document.data['image'],
          id:document.documentID

      );
    }).toList();

  }




  Future updateRecipe(String name,String recipe,String ingredients ,String image)async{

    final newRecipe = recipecollection.document();

    return await newRecipe.setData(
        {
          'name': name,
          'recipe': recipe,
          'ingredient': ingredients,
          'image':image,
          'id': newRecipe.documentID,




        });

  }
  Future updateRecipeItem(String name,String recipeText,String ingredients,Recipe recipe)async{

   return await recipecollection.document(
       recipe.id).updateData(
     {'name': name,
      'recipe': recipeText,
      'ingredient': ingredients,
      'image':recipe.image,
      'id': recipe.id});



  }





}