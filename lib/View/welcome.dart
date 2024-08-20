
// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Authservices/auth_services.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/register_signin_classes.dart';
import 'package:myshop/View/homepage.dart';
import 'package:myshop/View/register.dart';
class welcome extends StatefulWidget{
   const welcome({super.key});
  @override
  Welcome createState ()=> Welcome();
}


class Welcome extends State<welcome>{
 
  bool hide=true;
  TextEditingController username0 = TextEditingController();
        TextEditingController password0 = TextEditingController();
         String username = '';
        String password ='';
  @override
  Widget build(BuildContext context) {
    
        

    return Scaffold(
      
  backgroundColor: const Color.fromARGB(249, 252, 252, 252),
  body:SingleChildScrollView(
    child:Padding(
    padding: const EdgeInsets.all(16.0), // Ajoute un padding global
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligne les textes à gauche
      children: [
         Padding(padding:const  EdgeInsets.only(bottom: 30.0,left: 10.0,right: 10.0,top: 10.0),
       child: Image.asset('images/tof1.jpg'),),
        const Text(
          'Login',
          style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 8.0), // Espace entre "Login" et "Please Sign in"
        const Text(
          'Please Sign in to continue.',
          style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
          ),
        ),
        const SizedBox(height: 20.0), // Espace entre le texte et le TextField
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: TextField(
            controller: username0,
            decoration: InputDecoration(
              
              prefixIcon: const Icon(
                Icons.person_2_outlined,
                color: Color.fromARGB(84, 146, 172, 183),
              ),
              hintText: 'Username',
              hintStyle:const TextStyle(
                color:  Color.fromARGB(255, 20, 58, 74)
              ),
              filled: true,
              fillColor:const Color.fromARGB(134, 225, 233, 238),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 20, 58, 74),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 20, 58, 74),
                  width: 2.0,
                ),
              ),
            ),
            onChanged: (value) {

               username=username0.text;
            },
          ),
        ),
        const SizedBox(height: 8.0), // Espace entre le texte et le TextField
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: TextField(
            controller: password0,
            obscureText: hide,
            decoration: InputDecoration(
            
              prefixIcon: const Icon(
                Icons.lock,
                color: Color.fromARGB(84, 146, 172, 183),
              ),
              hintText: 'Password',
              hintStyle:const TextStyle(
                color:  Color.fromARGB(255, 20, 58, 74)
              ),
              filled: true,
              fillColor:const Color.fromARGB(134, 225, 233, 238),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 20, 58, 74),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 20, 58, 74),
                  width: 2.0,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: (){
                   setState(() {
                     hide= !hide;
                     print(hide);
                   });
                }, 
                icon: Icon(
            // ignore: dead_code
            hide ? Icons.visibility_off : Icons.visibility,
          ),)
            ),
          
            onChanged: (value) {
             password=password0.text;
               
            },
          ),
        ),
      
        const Padding(
          padding:EdgeInsets.only(left: 10.0,top:8.0,bottom: 20.0),
          child:  Text(
          'forget your password?',
          style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
          ),
        ),),
         Padding(padding:const EdgeInsets.only(left: 2.0),
        child: TextButton(
          
          onPressed: () async {
            await SignInWithEmailAndPassword(username,password);
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const Homepage()),
          );
          }, 
          style:const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(500)),
              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
            ),
          child:const Center(
            child: Text('Sign in',
            style: TextStyle(
              color:  Color.fromARGB(255, 209, 216, 225)
            ),),
          )
            )),

             const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Or sign in with",
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 58, 74),
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: TextButton(
                      style:const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
                      ),
                      onPressed: () async{ 
                        UserCredential? us=await signInWithGoogle(context);
                                     if (us?.additionalUserInfo?.isNewUser ?? false) {
                                      print('new');
        // C'est un nouvel utilisateur, redirigez-le vers le formulaire d'inscription
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      } else {
        // L'utilisateur existait déjà, continuez vers l'écran principal
        print('old');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
                       },
                      child: Row(
                        children: [
                         Image.asset('images/google.png',
                         height: 20,),
                        const SizedBox(width:  10.0,),
                        const Text('Google',
                              style: TextStyle(
                                fontSize: 20,
                              color:  Color.fromARGB(255, 209, 216, 225)
                           ),)
                        ],
                      ),)),
                     const SizedBox(width: 5.0,),
                       Expanded(
                child: TextButton(
                      style:const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
                      ),
                      onPressed: () {  },
                      child: Row(
                        children: [
                         Image.asset('images/icons_facebook96.png',
                         height: 24,),
                        const SizedBox(width:  10.0,),
                        const Text('Facebook',
                              style: TextStyle(
                                fontSize: 20,
                              color:  Color.fromARGB(255, 209, 216, 225)
                           ),)
                        ],
                      ),))
            ],
          ),
            Row(
             children: [
             const  Text('Don\'t have account?',
              style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
          ),),
              TextButton(
                onPressed: (){
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const RegisterScreen()),
          );
                }, 
                child:const Text('Sign up',
                style: TextStyle(
                 color:  Color.fromRGBO(2, 37, 70, 0.976),
                 fontWeight: FontWeight.w700
                ),))
             ],
          )
      ],
    ),
  ), 
  ) 
  

);

  }
   
  
}

/* ElevatedButton(onPressed: (){
                    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
                 },
ElevatedButton(onPressed: (){
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const RegisterScreen()),
          );
                },*/                 

   