// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:myshop/Model/user.dart';

//register
Future RegisterWithEmailAndPassword(String emailAddress,String password,User1 U)async{
    try {
  
   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  User? user = userCredential.user!;
   User1 user1 = User1(
     FirstName:U.FirstName,
      LastName: U.LastName,
      DateofBirth: U.DateofBirth,
      EnterpriseName: U.EnterpriseName,
      Description: U.Description,
      Adress: U.Adress,
      Email: U.Email,
      UId: user.uid,
    );

    
     await FirebaseFirestore.instance.collection('Users').doc(user1.UId).set(user1.toMap());
     await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('Items').add({});
      /*await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('orders').add({});
      await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('Deliveries').add({});
      await FirebaseFirestore.instance.collection('Users').doc(user1.UId).collection('invoices').add({});*/
  return user;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}
//sigin
Future SignInWithEmailAndPassword(String emailAddress,String password) async{
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
  return credential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
}

void initializeUserInFirestore(User1 user) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Ajouter l'utilisateur à Firestore
  await firestore.collection('Users').doc(user.UId).set(user.toMap());
}
