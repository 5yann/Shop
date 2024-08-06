// ignore_for_file: camel_case_types, library_private_types_in_public_api, avoid_print, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Model/register_signin_classes.dart';
import 'package:myshop/Model/user.dart';


class register extends StatefulWidget{
  const register({super.key});


   @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<register>{

  FirebaseFirestore db = FirebaseFirestore.instance;

  String FirstName = '';
  String LastName = '';
  String DateofBirth = '';
  String EnterpriseName = '';
  String Description = '';
  String Adress = '';
  String Email = '';
  String UId = '';

  
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String password = '';
  
  @override
  Widget build(BuildContext context) {
     return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "FirstName"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  setState(() => FirstName = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "LastName"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  setState(() => LastName = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "DateofBirth"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  setState(() => DateofBirth = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "EnterpriseName"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  setState(() => EnterpriseName = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "Description of your shop"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'empty field';
                     return null;
                },
                onChanged: (val) {
                  setState(() => Description = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "your Adress"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'enter your adress';
                     return null;
                },
                onChanged: (val) {
                  setState(() => Adress = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "your email"),
                validator: (val) {
                  if(val==null || val.isEmpty) return 'enter your email';
                     return null;
                },
                onChanged: (val) {
                  setState(() => Email = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: "password with at least 6 characters"),
                obscureText: true,
                validator: (val){
                  if(val !=null && val.length <6) return 'Enter a password 6+ chars long';
                  return null;
                },
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                    
                  if(_formKey.currentState!.validate()){
                    User1 U=User1(FirstName: FirstName, LastName: LastName, DateofBirth: DateofBirth, EnterpriseName: EnterpriseName, Description: Description, Adress: Adress, Email: Email, UId: UId);
                    User? result = await RegisterWithEmailAndPassword(Email, password,U);
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                    else{
                      print(result.uid);
                      print(result.email);
                      
                         /* Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => userhome()),
            );*/
                    }
                  }
                }
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      );
  }


}