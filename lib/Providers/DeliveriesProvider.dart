// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';

class Deliveriesprovider with ChangeNotifier{

     List<Delivery> deliveries= [];
     //List<Delivery> Clients = [];
     //List<Delivery> Clients = [];
     //List<Delivery> Clients = [];

    adddl(Delivery D) {
    //add to provider list
    deliveries.add(D);
    //add to database
    notifyListeners();
  }

  removedl(Delivery D) {
    //remove to provider list
    deliveries.remove(D);
    //update in data base 
    notifyListeners();
  }

  List<Delivery> getdeliveries(String S){
    return deliveries.where((delivery) => delivery.status.compareTo(S)==0).toList();
  }
  Delivery getD(String title){
    return deliveries.firstWhere((item)=>item.title.compareTo(title)==0);
  }

  updateDelivery(Delivery D){
      getD(D.title).status=D.status;
      notifyListeners();

  }
}