// ignore_for_file: prefer_collection_literals, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:provider/provider.dart';

import '../../Providers/DeliveriesProvider.dart';


class DeliveriesReadyPage extends StatefulWidget {
  @override
  _DeliveriesReadyPage createState() => _DeliveriesReadyPage();
}

class _DeliveriesReadyPage extends State<DeliveriesReadyPage> {
  bool isSelectionMode = false;
  Set<String> selectedItems = Set<String>();

  @override
  Widget build(BuildContext context) {
    List<Delivery> items = context.watch<Deliveriesprovider>().getdeliveries('Ready');
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title:const  Text('Deliveries ready'),
        actions: [
            if(!isSelectionMode)
           PopupMenuButton<String>(
        onSelected: (String result) {
          switch (result) {
            case 'delete':
             if(items.isNotEmpty){
               setState(() {
                isSelectionMode = !isSelectionMode;
                if (!isSelectionMode) {
                  selectedItems.clear();
                }
              });
             }
              break;
            case 'new delivery':
              // Handle another option
             /* Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const newDelivery(item: 0)),
            );*/
             
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
           const PopupMenuItem<String>(
            value: 'new delivery',
            child: Text('new delivery'),
          ),
         const  PopupMenuItem<String>(
            value: 'delete',
            child: Text('Delete'),
          ),
        ],
        child: const Icon(Icons.format_list_bulleted_outlined)
      ),
      
        ],
      ),
     body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: inkWelldeliverydetails(context, items[index],'In Progress',true),
            leading: isSelectionMode
                ? Checkbox(
                    value: selectedItems.contains(items[index].title),
                    onChanged: (bool? selected) {
                       setState(() {
                           if (selected != null && selected) {
                             selectedItems.add(items[index].title);
                           } else {
                                selectedItems.remove(items[index].title);
                                }
                                  });
                    },
                  )
                : null,
            onTap: () {
              bool? selected =!selectedItems.contains(items[index].title);
              if (isSelectionMode) {
                    setState(() {
                     if (selected) {
                             selectedItems.add(items[index].title);
                               } else {
                             selectedItems.remove(items[index].title);
                              }
                                 });
                          }
            },
          );
        },
      ),
      bottomNavigationBar: isSelectionMode
          ? BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${selectedItems.length} item(s) selected',
                      style:const  TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed:(){
                       
                        setState(() {
                            isSelectionMode = !isSelectionMode;
                              });
                              
                            
                            showDialog(context: context, 
                            builder: (BuildContext ctx) {
                                 
                                  return AlertDialog(
                                    title:const  Text('Are you sure you want to delete ?'),
                                    content: Row(
                                      children: [
                                        TextButton(
                                     onPressed: (){
                                       final providervalue =context.read<Deliveriesprovider>();
                                     for(String elt in selectedItems){
                              Delivery D= context.read<Deliveriesprovider>().getD(elt);
                               for(int i=0;i<D.itemsid.length;i++){
                              Item I = context.read<itemsProvider>().getItem(D.itemsid[i]);
                                  I.quantity=I.quantity+D.itemsqty[i];
                                 context.read<itemsProvider>().updadeItem(I, context, false);
                                   }
                              providervalue.removedl(D);
                            }
                            
                             Navigator.pop(context);
                             
                                     },
                                     child:const  Text('yes')),
                                     TextButton(
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                     child:const  Text('no')),
                                      ],
                                    )
                                  );   
                                        });
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.red, fontSize: 18,
                        fontWeight: FontWeight.w900),
                        
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }





}

