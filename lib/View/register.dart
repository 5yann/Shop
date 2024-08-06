// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myshop/Controller/registerFieldcontrol.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});


   @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<RegisterScreen>{

 
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
         title: const Text('Register'),
        backgroundColor:const Color.fromARGB(128, 169, 97, 14),
      ),
      body: const SingleChildScrollView(
        child:  register(),
      )
     
     );
  }


}