import 'package:cloud_firestore/cloud_firestore.dart';
import 'iteems/item_category.dart';

class Supplier {
  final int  id;
  final String name;
  final String contact;
  final String? adress;
  final String? email;
  int  itemsdelivered;
  List<Item> list ;
  
  Supplier ({required this.id,
  required this.name,
  required this.contact,
  required this.adress,
  required this.email,
  required this.itemsdelivered,
  required this.list,});

  Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'contact':contact,
     'adress':adress,
     'email':email,
     'itemsdelivered':itemsdelivered,
     'list' : list,
    };
  }

  factory Supplier.fromDocument(DocumentSnapshot doc) {
    return Supplier(
      id:doc['id'],
      name: doc['name'],
      contact: doc['contact'],
      adress: doc['adress'],
      email: doc['email'],
      itemsdelivered:doc['itemsdelivered'],
      list: doc['list']
    );
  }
}