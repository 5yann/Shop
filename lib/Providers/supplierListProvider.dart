// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../Controller/supplierContoller.dart';
import '../Model/iteems/item_category.dart';
import '../Model/suppliers.dart';

class Supplierlistprovider with ChangeNotifier {
  List<Supplier> Suppliers = [];
  Map<String, double> dataMap ={};
  List<Color> colors =[];
   bool isEmpty =false;

  addsup(Supplier S) {
    //add to provider list
    Suppliers.add(S);
    colors= generateDistinctColors(colors);
    dataMap['${S.name}_${S.email}'] = S.itemsdelivered.toDouble();
    isEmpty=true;
    //add to database
    notifyListeners();

  }

  removesup(Supplier S) {
    //remove to provider list
    Suppliers.remove(S);
    //update in data base 
    notifyListeners();
  }

  Supplier getSupplier(int id){
    return Suppliers.firstWhere((item)=>item.id==id);
  }



 
   addItemsOnSupp(List<Item> list,Supplier s){
      for(int i=0;i<list.length;i++){
        if(!Suppliers.firstWhere((item)=>item.id==s.id).list.contains(list[i])){
          Suppliers.firstWhere((item)=>item.id==s.id).list.add(list[i]);
          list[i].suppliers.add(s);
        }
      }
      notifyListeners();
   }
}