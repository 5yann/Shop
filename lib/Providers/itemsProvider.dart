// ignore_for_file: file_names, camel_case_types,, unused_element, prefer_final_fields 

import 'package:flutter/material.dart';
import 'package:myshop/Model/iteems/item_category.dart';

import '../Model/suppliers.dart';

class itemsProvider with ChangeNotifier {
  List<Item> globalItems = [];
  List<Item> categoryItems = [];

     List<Item> selectedProducts = [];
     List<int> selectedProductsqty = [];
     List<Item> displayedSuggestions=[];

   intstate(){
    selectedProducts.clear();
    selectedProductsqty.clear();
   }
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

  updateQties(List<int> itemsid,List<int> itemsqty){
    for(int j=0;j<itemsid.length;j++){
    double x= getItem(itemsid[j]).quantity ;
    getItem(itemsid[j]).quantity=x+itemsqty[j];
    }
    notifyListeners();
  }


    void onSuggestionSelected(Item suggestion) {
      selectedProducts.add(suggestion);
      selectedProductsqty.add(1);
      displayedSuggestions.add(suggestion);
      notifyListeners();
  }

  void increaseQuantity(int n) {
      selectedProductsqty[n]++;
       notifyListeners();
  }

  void decreaseQuantity(int n) {
        selectedProductsqty[n]--;  
         notifyListeners();
  }
  removeonSel(Item i,int n){
    selectedProducts.remove(i);
    selectedProductsqty.removeAt(n);
    notifyListeners();
  }

  addSuplliers(List<Supplier> list,Item it){
     for(int i=0;i<list.length;i++){
      if(!getItem(it.id).suppliers.contains(list[i])){
        globalItems.firstWhere((item)=> item.id==it.id).suppliers.add(list[i]);
        list[i].list.add(it);

      }
     }
     notifyListeners();
  }


}