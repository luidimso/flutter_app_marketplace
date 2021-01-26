import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> user = Map();


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadUserData();
  }

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
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signin(String email, String password, VoidCallback onSuccess, VoidCallback onFail) async {
    isLoading = true;
    notifyListeners();
    
    _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    ).then((value) async {
      firebaseUser = value;

      await _loadUserData();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signout() async {
    await _auth.signOut();
    user = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPassword(String email) {
    _auth.sendPasswordResetEmail(
        email: email
    );
  }

  bool isLogged() {
    return firebaseUser != null;
  }

  Future<Null> _saveUser(Map<String, dynamic> user) async {
    this.user = user;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(user);
  }

  Future<Null> _loadUserData() async {
    if(firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }

    if(firebaseUser != null) {
      if(user["name"] == null) {
        DocumentSnapshot doc = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        user = doc.data;
      }
    }

    notifyListeners();
  }
}