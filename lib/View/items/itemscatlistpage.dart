//list of items per category
import 'package:flutter/material.dart';
import 'package:myshop/Controller/items/cattegoryitemlist.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:provider/provider.dart';


class Itemscatlistpage extends StatelessWidget {
  final String text;
  
   // ignore: use_super_parameters
   const Itemscatlistpage ({Key? key, required this.text, }) : super(key: key);





  @override
  Widget build(BuildContext context) {

     List<Item> filteredItems =context.watch<itemsProvider>().getitemsbycategory(text);
    return Scaffold(
          appBar: AppBar(
            title:  Text(text),
            backgroundColor: const Color.fromARGB(255, 7, 81, 255),
            actions: [
              IconButton(
              onPressed: (){
                showSimpleDialogAddItemInCat(context,text);
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
             CategoryItemsList(filteredItems: filteredItems,)
            ]),
        )
    ;
  }
}