// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/deliveryCompletedModel.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:provider/provider.dart';


class DeliveriesCompletedPage extends StatefulWidget {
  @override
  _DeliveriesCompletedPage createState() => _DeliveriesCompletedPage();
}

class _DeliveriesCompletedPage extends State<DeliveriesCompletedPage>{
 
  

  @override
  Widget build(BuildContext context) {
   List<Delivery> items = context.watch<Deliveriesprovider>().getdeliveries('Completed');
    SelectionModeNotifier selectionNotifier = context.watch<SelectionModeNotifier>();
    bool isEmpty=items.isEmpty;
   return Scaffold(

    appBar: appBarDelComp(selectionNotifier,isEmpty,'Deliveries Completetd',Colors.greenAccent),
    body: bodyDelivComp(items,selectionNotifier),
    bottomNavigationBar: selectionNotifier.isSelectionMode
          ?bottomAppBarComp(selectionNotifier, items,context)
          :null
   );
  }

}