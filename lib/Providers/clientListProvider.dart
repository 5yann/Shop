// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/supplier_bill_client.dart';

class Clientlistprovider with ChangeNotifier {
  List<Client> Clients = [];
  

  addcl(Client C) {
    //add to provider list
    Clients.add(C);
    //add to database
    notifyListeners();
  }

  removecl(Client C) {
    //remove to provider list
    Clients.remove(C);
    //update in data base 
    notifyListeners();
  }
  
  Client getcl(int id){
 return Clients.elementAt(id);
  }
}