import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/deliveryCompletedModel.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:provider/provider.dart';

class ClientDeliveriesController extends StatelessWidget{
  final int id;
  const ClientDeliveriesController({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    List<Delivery> items = context.watch<Deliveriesprovider>().deliveries.where((item)=> item.idclient==id).toList();
    SelectionModeNotifier selectionNotifier = context.watch<SelectionModeNotifier>();
    bool isEmpty=items.isEmpty;
   return Scaffold(

    appBar: appBarDelComp(selectionNotifier,isEmpty,'Deliveries',const Color.fromARGB(255, 111, 31, 148)),
    body: bodyDelivComp(items,selectionNotifier),
    bottomNavigationBar: selectionNotifier.isSelectionMode
          ?bottomAppBarComp(selectionNotifier, items,context)
          :null
   );
  }
  
}