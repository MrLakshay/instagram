import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram/model/user.dart' as modal;
import 'package:flutter/material.dart';
import 'package:instagram/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<modal.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snapshot=await _firestore.collection('users').doc(currentUser.uid).get();
    return modal.User.fromSnap(snapshot);
  }
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res="Some error occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res="success";
        return res;
      }
      else{
        res="Enter all the fields";
        return res;
      }
    }
    catch(e){
      return e.toString();
    }
  }

  //signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoURL = await StorageMethods()
            .uploadImagetoStorage('profilePics', file, false);
        modal.User user= modal.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
          bio: bio,
          followers: [],
          followings: [],
          photoUrl: photoURL,
        );
        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res = 'success';
      }
    } catch (err) {
      //
      res = err.toString();
    }
    return res;
  }
}
