import 'package:brew_crew/models/sys_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  // AuthService(this._auth);

  //create a user object based on firebase user

  Sys_user? _userFromFirebaseUser(User? user){
    if(user==null){
      return null;
    }else{
      return Sys_user(uid: user.uid);
    }
  }

  //auth change user stream

  Stream<Sys_user?> get authStateChanges => _auth.idTokenChanges().map((user) => _userFromFirebaseUser(user));

  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential result=await _auth.signInAnonymously();
      User user=result.user!;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }




  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      //create a new document for the user with the uid

      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);


      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future<void> signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}