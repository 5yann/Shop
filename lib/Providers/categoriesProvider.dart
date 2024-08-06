// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/iteems/item_category.dart';

class CategoriesProvider with ChangeNotifier {
  List<Category> Categories = [];
  

  addcat(Category C) {
    //add to provider list
    Categories.add(C);
    //add to database
    notifyListeners();
  }

  removecat(String s) {
    //remove to provider list
    for (Category C in Categories){
      if(C.categoryname.compareTo(s)==0) Categories.remove(C);
    }
    //update in data base 
    notifyListeners();
  }

}