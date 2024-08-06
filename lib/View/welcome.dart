
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:myshop/View/homepage.dart';
import 'package:myshop/View/register.dart';

class welcome extends StatelessWidget{
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Stack(
      children: [ 
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
                Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ 
                 ElevatedButton(onPressed: (){
                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
                 },
                 
                  child: const Text('SignIn',)),
                  const Text('or'),
                ElevatedButton(onPressed: (){
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const RegisterScreen()),
          );
                },
                  child: const Text('Register'))
            ],
           )
            ],
           ),
           
      ],
            )
    );
  }

  
}