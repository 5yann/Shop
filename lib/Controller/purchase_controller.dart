
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/suppliers.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:myshop/View/purchase/purchases_view.dart';
import 'package:provider/provider.dart';

import '../Model/homepagewidgets.dart';
import '../Model/iteems/item_category.dart';
import '../Model/purchase/purchases_model.dart';
import '../Providers/itemsProvider.dart';
import '../Providers/purchase_Provider.dart';

InkWell inkWellPurchase(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchasesView()),
            );
          },
    child: card(S),
  );
}

Widget wallpaper(){
  return  Positioned.fill(
              child: Image.asset(
                'images/wp2.jpg',
                fit: BoxFit.cover,
              ),
            );
}

AlertDialog statuschangeToR(BuildContext context ,Purchase p){
  return AlertDialog(
                                title:const  Text('Do you want to change your the status of this Delivery to Receptionned and Update your stock?'),
                                content: Row(
                                children: [
                                  TextButton(
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                                  TextButton(
                                     onPressed: (){
                                       p.status='Receptionned';
                                       context.read<Purchase_Provider>().updatePurchaseStatus(p);
                                       updateQty(p.itemsid, p.itemsqty, context);
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('yes')),                     
                                   ],
                                 ),
                              );
}

 List<Widget> buildRowsP(Purchase D,BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < D.itemsid.length; i++) {
      rows.add(
        Row(
          children: [
           Text('Item $i : ${context.read<itemsProvider>().getItem(D.itemsid[i]).name}'),
           Text('${context.read<itemsProvider>().getItem(D.itemsid[i]).price} * ${D.itemsqty[i]}')
          ],
        ),
      );
    }
    return rows;
  }

  void updateQty(List<int> itemsid,List<int> itemsqty,BuildContext context){
      context.read<itemsProvider>().updateQties(itemsid,itemsqty);
  }


  AlertDialog warningDeletepurchase(BuildContext context,SelectionModeNotifier selectionNotifier ,List<Purchase> items){
  return AlertDialog(
         title:const  Text('Are you sure you want to delete ? be sure please'),
          content: Row(
                                      children: [
                                        TextButton(
                                     onPressed: (){
                                     
                                       final providervalue =context.read<Purchase_Provider>();
                                     for(String elt in selectionNotifier.selectedItems){
                                     
                              Purchase P= providervalue.getPurchase(int.parse(elt));   
                              providervalue.removePurchase(P);
                              
                            }
                             selectionNotifier.toggleSelectionMode();
                           
                             Navigator.pop(context);
                              
                           
                                     },
                                     child:const  Text('yes')),
                                     TextButton(
                                     onPressed: (){
                                      selectionNotifier.toggleSelectionMode();
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                                      ],
                                    )
  );
}



List<Purchase> createPurchase(List<Item> items, List<int> itmsqty,BuildContext context,int id){
  List<Purchase> P=[];
  
  Map<Supplier,List<Temp>> data ={};
  Supplier s=items[0].suppliers[0];
     for(int i=0;i<items.length;i++){
       if(items[i].suppliers.length >1){
         //s = getOneSupp(items[i], context);
       }
       else{
         s=items[i].suppliers[0];
       }
       
        if(!data.containsKey(s)){
          data[s]=[];
        }
        data[s]?.add(Temp(n: itmsqty[i], item: items[i]));
     }
     int n=id;
     data.forEach((key,value){
      double totalP=0;
      n++;
      List<int> list=[];
      List<int>  qties=[];
      for(int i=0;i<value.length;i++){
        list.add(value[i].item.id);
        qties.add(value[i].n);
        totalP=totalP+ (value[i].n* value[i].item.Pprice).toInt();
      }
      P.add(
        Purchase(id: n, 
                 price: totalP, 
                 providerId: key.id, 
                 date: DateTime.now().toString(), 
                 itemsid: list, 
                 itemsqty: qties, 
                 status: 'In Progress')
      );
     }
     );
     return P;
}