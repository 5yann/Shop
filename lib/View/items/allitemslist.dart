import 'package:flutter/material.dart';
import 'package:myshop/Controller/items/cattegoryitemlist.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:provider/provider.dart';

class Allitemslist extends StatelessWidget {
  const Allitemslist({super.key});





  @override
  Widget build(BuildContext context) {
    
    List<Item> allItems =context.watch<itemsProvider>().globalItems;

    return Scaffold(
          appBar: AppBar(
            title: const Text("My Items"),
            backgroundColor: const Color.fromARGB(255, 7, 81, 255),
            actions: [
              IconButton(
              onPressed: (){
                //showSimpleDialogcat(context);
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
             CategoryItemsList(filteredItems:allItems),
            ]),
        )
    ;
  }
}