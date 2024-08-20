// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/Controller/purchase_controller.dart';
import 'package:myshop/Model/iteems/item_category.dart';
import 'package:myshop/Model/purchase/purchases_model.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/Providers/purchase_Provider.dart';
import 'package:provider/provider.dart';

class Newpurchase extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   TextEditingController _controller=TextEditingController();
   List<Item> _suggestions = List<Item>.from(Provider.of<itemsProvider>(context, listen: false).globalItems);
   final providerValue=context.watch<itemsProvider>();
   providerValue.intstate;
   return Scaffold(
    appBar: AppBar(
        title: const  Center(
                child: Text('New Purchase',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),),),
                backgroundColor: Colors.black87,
    ),
    
     body:
      Column(
            children: [
                Expanded(
                child: TextField(
                  controller: _controller,
                  decoration:const InputDecoration(
                    hintText: 'Select an item',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: ()=>{
                    showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return ListView.builder(
                          itemCount: _suggestions.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              title: Text(_suggestions[index].name),
                              onTap: () {
                                providerValue.onSuggestionSelected(_suggestions[index]);
                                _suggestions.remove(_suggestions[index]);
                                _controller.clear();
                                Navigator.pop(context);
                              },
                            );
                          }
                          );
                      })
                  },
                ),
              ),
             const  SizedBox(height: 20),
              Expanded(
            child: ListView.builder(
              itemCount: providerValue.selectedProducts.length,
              itemBuilder: (context, index) {
                final item = providerValue.selectedProducts[index];
                return ListTile(
                  title: Text(item.name,
                            style:const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200
                )),
                  subtitle: Text('Quantity: ${providerValue.selectedProductsqty[index]}',
                  style:const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200
                )),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon:const  Icon(Icons.delete),
                        onPressed: () {
                          _suggestions.add(item);
                         providerValue.removeonSel(item, index);
                        },
                      ),
                      IconButton(
                        icon:const  Icon(Icons.add),
                        onPressed: () {
                          providerValue.increaseQuantity(index);
                        },
                      ),
                      IconButton(
                        icon:const  Icon(Icons.remove),
                        onPressed: () {
                          providerValue.decreaseQuantity(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
            ],
          ),
          bottomNavigationBar: providerValue.selectedProducts.isNotEmpty
          ? BottomAppBar(
              child: TextButton(
                onPressed: () {
                  final providerValue1=context.read<Purchase_Provider>();
                  int n=providerValue1.getId();
                  List<Purchase>   Ps= createPurchase(providerValue.selectedProducts, providerValue.selectedProductsqty, context,n);
                  for(int i=0;i<Ps.length;i++){
                    providerValue1.addPurchase(Ps[i]);
                  }
                  providerValue.intstate();
                 Navigator.pop(context);
                }, 
                child: const  Text('Create')),
          )
          :null
   );
  }
  
}