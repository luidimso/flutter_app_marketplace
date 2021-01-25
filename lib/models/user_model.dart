import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> user = Map();

  void signup(Map<String, dynamic> user, String password, VoidCallback onSuccess, VoidCallback onFail) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: user["email"],
      password: password
    ).then((value) async {
      firebaseUser = value;

      await _saveUser(user);

      onSuccess();
      isLoading = true;
      notifyListeners();
    }).catchError((error) {
      onFail();
      isLoading = true;
      notifyListeners();
    });
  }

  void signin() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void recoverPassword() {

  }

  Future<Null> _saveUser(Map<String, dynamic> user) async {
    this.user = user;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(user);
  }
}