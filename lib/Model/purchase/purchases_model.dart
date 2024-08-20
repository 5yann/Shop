import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshop/Model/iteems/item_category.dart';


class Purchase{
final int id;
double price ;
final int providerId;
final String date ;
List<int> itemsid;
List<int> itemsqty;
String status;
Purchase({required this.id, required this.price,required this.providerId,required this.date,required this.itemsid,required this.itemsqty,required this.status}
);

  Map<String, dynamic> toMap() {
    return {
     'id':id,
     'price':price,
     'providerId':providerId,
     'date': date,
     'items' :itemsid,
     'itemsid' :itemsqty,
     'status':status
    };
  }

   factory Purchase.fromDocument(DocumentSnapshot doc) {
    return Purchase(
      id: doc['id'],
      price: doc['price'],
      providerId:doc['providerId'],
      date:doc['date'],
      itemsid:doc['itemsid'],
      itemsqty:doc['itemsqty'],
      status:doc['status']
    );
  }
}

class Temp{
  late int n;
  late Item item;
  Temp({required this.n,required this.item});
}