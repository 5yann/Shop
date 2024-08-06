// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/deliveryModels/deliveryInprogressModels.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
import 'package:myshop/Providers/DeliveriesProvider.dart';
import 'package:myshop/Providers/deliveriesSelectionmodeNotifier.dart';
import 'package:provider/provider.dart';


class DeliveriesInProgressPage extends StatefulWidget {
  @override
  _DeliveriesInProgressPage createState() => _DeliveriesInProgressPage();
}

class _DeliveriesInProgressPage extends State<DeliveriesInProgressPage>{
 
  

  @override
  Widget build(BuildContext context) {
   List<Delivery> items = context.watch<Deliveriesprovider>().getdeliveries('In Progress');
    SelectionModeNotifier selectionNotifier = context.watch<SelectionModeNotifier>();
    bool emty=items.isEmpty;
   return Scaffold(

    appBar: appBarInP(selectionNotifier,emty),
    body: bodyDelivInprog(items,selectionNotifier),
    bottomNavigationBar: selectionNotifier.isSelectionMode
          ?bottomAppBarInP(selectionNotifier, items,context)
          :null
   );
  }

}