// ignore_for_file: use_build_context_synchronously, avoid_print, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myshop/View/homepage.dart';
import 'package:myshop/View/register.dart';


   
   

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
   final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // L'utilisateur a annulé la connexion
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print(e); // Gérer les erreurs ici
    }
  }

