// ignore_for_file: file_names

import  'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:provider/provider.dart';

AppBar appBarDelComp(SelectionModeNotifier selectionNotifier,bool isEmpty,String s, Color c){
  return AppBar(
    backgroundColor: c,
    title: Text(s),
    actions: [
      IconButton(
       onPressed: (){  
        if(!isEmpty) selectionNotifier.toggleSelectionMode();
       },
       icon:const Icon(
        Icons.delete
       ))
    ],

  );
}

ListView bodyDelivComp(List<Delivery> items,SelectionModeNotifier selectionNotifier){
 // print(isSelectionMode);
return ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index){
   // final item = items[index];
          final isSelected = selectionNotifier.selectedItems.contains(items[index].title);
    return ListTile(
          title: inkWelldeliverydetails(context, items[index],'',false),
          leading: selectionNotifier.isSelectionMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      selectionNotifier.toggleItemSelection(items[index].title);
                    },
                  )
                : null,
            onTap: selectionNotifier.isSelectionMode
            ?() {
              selectionNotifier.toggleItemSelection(items[index].title);
            }
            :null,
    );
  });
 
}

 BottomAppBar bottomAppBarComp(SelectionModeNotifier selectionNotifier,List<Delivery> items,BuildContext context){
  return BottomAppBar(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
                      '${selectionNotifier.selectedItems.length} item(s) selected',
                      style:const  TextStyle(fontSize: 18),
                    ),
          TextButton(
            onPressed: (){
                showDialog(
                context: context, 
                builder:(BuildContext ctx){
                  return  warningDeleteDelivComp(context,selectionNotifier, items);
                } );

            }, 
            child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.red, fontSize: 18,
                        fontWeight: FontWeight.w900),
                        
                      ),)          
        ],
      ),),
  );
}

AlertDialog warningDeleteDelivComp(BuildContext context,SelectionModeNotifier selectionNotifier ,List<Delivery> items){
  return AlertDialog(
         title:const  Text('Are you sure you want to delete ?'),
          content: Row(
                                      children: [
                                        TextButton(
                                     onPressed: (){
                                     
                                       final providervalue =context.read<Deliveriesprovider>();
                                     for(String elt in selectionNotifier.selectedItems){
                                     
                              Delivery D= context.read<Deliveriesprovider>().getD(elt);
                              providervalue.removedl(D);
                              
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