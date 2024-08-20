// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:myshop/Model/suppliers.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:provider/provider.dart';

import '../../Model/iteems/item_category.dart';


class ChooseSuppforItem extends StatefulWidget{
  final Item item;

  const ChooseSuppforItem({super.key, required this.item});
   @override
    State<ChooseSuppforItem> createState()=> choice();
}


class choice extends State<ChooseSuppforItem>{
  List<Supplier> select =[];
  @override
  Widget build(BuildContext context) {
     Item i= widget.item;
      final providervalue1 = context.read<Supplierlistprovider>();
      List<Supplier> listsup=providervalue1.Suppliers;
      final providervalue2 = context.read<itemsProvider>();
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Add supplier'),
        backgroundColor: Colors.cyan
      ),
      body: ListView.builder(
          itemCount: listsup.length,
          itemBuilder: (context,index){
            return CheckboxListTile(
              title:Column(
                children: [
                  Text(listsup[index].name),
                  Text(listsup[index].adress??'')
                ],
              ) ,
              value: select.contains(listsup[index]),
               onChanged: (bool?value){
                setState(() {
                   
                  if(value==true){
                    
                    select.add(listsup[index]);
                  }
                  else{
                     
                     select.remove(listsup[index]);
                  }
                });
               }
               );
          }
          ),
          bottomNavigationBar: BottomAppBar(
                                   child: TextButton(onPressed: () { 
                                             providervalue2.addSuplliers(select, i);
                                              Navigator.pop(context);
                                    },
                                                       child: const  Text('Ok'),),),
    );
  }
  
}

class ChooseItemsforSupp extends StatefulWidget{
  final Supplier item;

  const ChooseItemsforSupp({super.key, required this.item});
   @override
    State<ChooseItemsforSupp> createState()=> choice2();
}


class choice2 extends State<ChooseItemsforSupp>{
  List<Item> select =[];
  @override
  Widget build(BuildContext context) {
     final Supplier i= widget.item;
      final providervalue1 = context.read<Supplierlistprovider>();
      final providervalue2 = context.read<itemsProvider>();
      List<Item> listitems=providervalue2.globalItems;
      

    return Scaffold(
      appBar: AppBar(
        title:const  Text('Add supplier'),
        backgroundColor: Colors.cyan
      ),
      body: ListView.builder(
          itemCount: listitems.length,
          itemBuilder: (context,index){
            return CheckboxListTile(
              title:Column(
                children: [
                  Text(listitems[index].name),
                  Text(listitems[index].description??'')
                ],
              ) ,
              value: select.contains(listitems[index]),
               onChanged: (bool?value){
                setState(() {
                   
                  if(value==true){
                    
                    select.add(listitems[index]);
                  }
                  else{
                     
                     select.remove(listitems[index]);
                  }
                });
               }
               );
          }
          ),
          bottomNavigationBar: BottomAppBar(
                                   child: TextButton(onPressed: () { 
                                             providervalue1.addItemsOnSupp(select, i);
                                              Navigator.pop(context);
                                    },
                                                       child: const  Text('Ok'),),),
    );
  }
  
}