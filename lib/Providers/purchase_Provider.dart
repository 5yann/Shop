// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../Model/purchase/purchases_model.dart';

class Purchase_Provider with ChangeNotifier{
  List<Purchase> Purchases = [];
  
  int? selectSup;
  int id=0;


  addPurchase(Purchase P){
    Purchases.add(P);
    id++;
    notifyListeners();
  }

  removePurchase(Purchase P){
    Purchases.remove(P);
    notifyListeners();
  }

  Purchase getPurchase(int id){
    return Purchases.firstWhere((item)=>item.id==id);
  }

  updatePurchaseStatus(Purchase P){
    getPurchase(P.id).status=P.status;
    notifyListeners();
  }
  
  void selectRadiosup(int value){
        selectSup =value;
        notifyListeners();
  }
  getId(){
   return id;
  }
  
}