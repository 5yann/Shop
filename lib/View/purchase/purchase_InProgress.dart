// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myshop/Model/purchase/purchases_model.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:myshop/Providers/purchase_Provider.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:myshop/View/purchase/newpurchase.dart';
import 'package:provider/provider.dart';

import '../../Controller/purchase_Controller.dart';

class PurchaseInprogress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final providerValue = context.watch<Purchase_Provider>();
    List<Purchase> items = providerValue.Purchases.where((item)=> item.status.compareTo('In Progress')==0).toList();
    SelectionModeNotifier selectionNotifier =context.watch<SelectionModeNotifier>();
    bool b=true;
    return Scaffold(
       body:  Stack(
        children: [
          wallpaper(),
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              Purchase P=items[index];
                   final isSelected = selectionNotifier.selectedItems.contains(P.id.toString());
                   return ListTile(
                    title:InkWell(
                    onDoubleTap: () async {/*
                       Bill bill =getBill(D, context);
     
                       final pdfFile = await  generateInvoicePdf(bill, context);
                       await Printing.layoutPdf(
                       onLayout: (PdfPageFormat format) async => pdfFile,
                       );*/
                    },
                    onLongPress: () {
                      if(b){
                      showDialog(
                      context: context,
                      builder: (BuildContext ctx){
                      return statuschangeToR(context, P);
                             });
                            } 
                     }
                       ,
                        child: Card(
                     shadowColor: Colors.black,
                     color: Colors.deepPurple,
                     child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                             child:  Text('Purchase ${P.id}')),
                        const Divider(),
                        Column(
                              children: [
                                ...buildRowsP(P,context),
                                ],
                              ),
                        Text('                    Total : ${P.price}'),
                        const Divider(),
                       const Text('Supplier :'),
                        Text('name :${context.read<Supplierlistprovider>().getSupplier(P.providerId).name}'),
                        Text('contact : ${context.read<Supplierlistprovider>().getSupplier(P.providerId).contact}'),
                        Text('adress: ${context.read<Supplierlistprovider>().getSupplier(P.providerId).adress}'),
                        Text('create on ${P.date}'),
                          ],),
                                    )
                  ) ,
                 leading: selectionNotifier.isSelectionMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      selectionNotifier.toggleItemSelection(P.id.toString());
                    },
                  )
                : null,
            onTap: selectionNotifier.isSelectionMode
            ?() {
              selectionNotifier.toggleItemSelection(P.id.toString());
            }
            :null,
                   );
            }),
        ],
       ),
        floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.search),
            backgroundColor: Colors.green,
            label: 'Recherche',
            onTap: () => print('Recherche tapped'),
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Suppression',
            onTap: () =>selectionNotifier.toggleSelectionMode(),
          ),
          SpeedDialChild(
            child:const  Icon(Icons.add),
            backgroundColor: Colors.red,
            label: 'New Purchase',
            onTap: (){
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newpurchase()),
          );
            },
          ),
          
        ],
      ),
       bottomNavigationBar: selectionNotifier.isSelectionMode
          ?BottomAppBar(
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
                  return  warningDeletepurchase(context,selectionNotifier, items);
                } );

            }, 
            child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.red, fontSize: 18,
                        fontWeight: FontWeight.w900),
                        
                      ),)          
        ],
      ),)
          )
          :null,
    );
  }
  
}

