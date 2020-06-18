

import 'dart:math';
import 'dart:io';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File _image;
  String url;
  //create user based off of firebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    if (user.isEmailVerified) {
      return _userFromFirebaseUser(user);
    }
    return null;
  }

  //sign in email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    if (user.isEmailVerified) {
      return _userFromFirebaseUser(user);
    }
    return null;
  }

  //register supplier with email and pass
  Future registerSupplierWithEmailAndPassword(
      String fullName,
      String companyName,
      String phoneNumber,
      String email,
      String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;

    try {
      await user.sendEmailVerification();
      //create doc for supplier
      DatabaseService(uid: user.uid)
          .updateSupplierUserData(fullName, companyName, phoneNumber);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("An error occurred while trying to send email verification");
      print(e.message);
    }
  }

  //register buyer with email and pass
  Future registerBuyerWithEmailAndPassword(String url, String fullName, String companyName,
      String phoneNumber, String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    try {
      await user.sendEmailVerification();
      //create doc for supplier
      DatabaseService(uid: user.uid)
          .updateBuyerUserData(url,fullName, companyName, phoneNumber);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("An error occurred while trying to send email verification");
      print(e.message);
    }
  }

  //forgot password
  Future forgotpassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //sign out

  Future signOut() async {
    try {

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
