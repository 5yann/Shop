
import 'package:flutter/material.dart';
import 'package:myshop/Controller/categories/categoriesList.dart';
import 'package:myshop/Model/iteems/item_category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("My categories"),
            backgroundColor: const Color.fromARGB(255, 7, 81, 255),
            actions: [
              IconButton(
              onPressed: (){
                showSimpleDialogcat(context);
              }, 
              icon:const  Icon(Icons.add))
            ],
          ),
          body:Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'images/wp2.jpg',
                fit: BoxFit.cover,
              ),
            ),
             CategoriesList()
            ]),
        )
    ;
  }
}