// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/View/items/itemsdetails.dart';


class CategoryItemsList extends StatelessWidget {
  
   final List<Item> filteredItems;
 // ignore: use_super_parameters
   const CategoryItemsList  ({Key? key,required this.filteredItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     

    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: card(filteredItems[index].name),
          onTap: () {
            Item I = filteredItems[index];
           Navigator.push(
              context,
              
              MaterialPageRoute(builder: (context) => TabBarItemdetails(item :I)),
            );
          },
          onLongPress: (){
            UpdateOrRemoveItemAlertdialog(context, filteredItems[index]);
          },
        );


      },
      itemCount: filteredItems.length,
    );

  }
}