// ignore_for_file: file_names, camel_case_types, 

import 'package:flutter/material.dart';
import 'package:myshop/Model/iteems/item_category.dart';

class itemsProvider with ChangeNotifier {
  List<Item> globalItems = [];
  List<Item> categoryItems = [];



 /* addcat(Item I) {
    //add to provider catlist
    categoryItems.add(I);
    //add to database
    notifyListeners();
  }

  removecat(int id) {
    //remove to provider catlist
    for (Item I in categoryItems){
      if(I.id==id) categoryItems.remove(I);
    }
    //update in data base 
    notifyListeners();
  }*/

  
  addglob(Item I) {
    //add to provider globallist
    globalItems.add(I);
    //add to database
    notifyListeners();
  }

  removeglob(int id) {
    //remove to provider globallist
    globalItems.removeWhere((item)=>item.id==id);
    //update in data base 
    notifyListeners();
  }
  
  //get items by category
  List<Item> getitemsbycategory(String s){
  
    return globalItems.where((item)=>item.category==s).toList();
  }

  Item getItem(int id){
    return globalItems.firstWhere((item)=> item.id==id);
  }

  updadeItem(Item I,BuildContext context,bool increase){
     globalItems[I.id].quantity=I.quantity;
     notifyListeners();
  }
}