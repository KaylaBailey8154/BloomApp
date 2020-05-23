import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user based off of firebaseUser

  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
          .map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async{

    try{

      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e){
      print(e.toString());
      return null;
    }


  }

  //sign in email and pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }



  //register supplier with email and pass
  Future registerSupplierWithEmailAndPassword(String email, String password, String fullName, String companyName, String phoneNumber ) async{
    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser  user = result.user;

      //create doc for supplier
      await DatabaseService(uid: user.uid).updateSupplierUserData(fullName, companyName, phoneNumber);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
     }

  //register buyer with email and pass
  Future registerBuyerWithEmailAndPassword(String email, String password, String fullName, String phoneNumber ) async{
    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser  user = result.user;

      //create doc for supplier
      await DatabaseService(uid: user.uid).updateBuyerUserData(fullName, phoneNumber);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

}