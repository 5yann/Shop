// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/supplier_bill_client.dart';

class Supplierlistprovider with ChangeNotifier {
  List<Supplier> Suppliers = [];
  

  addsup(Supplier S) {
    //add to provider list
    Suppliers.add(S);
    //add to database
    notifyListeners();
  }

  removesup(Supplier S) {
    //remove to provider list
    Suppliers.remove(S);
    //update in data base 
    notifyListeners();
  }

}