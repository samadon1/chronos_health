import 'dart:typed_data';

import 'package:chronos_health/resources/storage_methods.dart';
import 'package:chronos_health/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String number,
    required String insurance,
    required String birthdate,
    required String name,
    required Uint8List file,
  }) async {
    String res = "An error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          number.isNotEmpty ||
          insurance.isNotEmpty ||
          birthdate.isNotEmpty ||
          name.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        //add user to database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "name": name,
          "number": number,
          "insurance": insurance,
          "birthdate": birthdate,
          "email": email,
          "photoUrl": photoUrl
        });
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "Invalid email format";
      } else if (err.code == "weak-password") {
        res = "Password should be at least 6 characters";
      } else if (err.code == "email-already-exists") {
        res = "Email is registered with another account";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "All fields are required";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = "wrong password";
      } else if (e.code == 'user-not-found') {
        res = 'user does not exist';
      } else {}
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
