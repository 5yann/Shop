
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:myshop/Controller/Delivery/deliveriesCompController.dart';
import 'package:myshop/Controller/Delivery/deliveriesInProg.dart';
import 'package:myshop/Controller/Delivery/deliveriesready.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';

class Deliveriesstatcontroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
    return Column(
      children: [ 
         deliverypiechart(context),
          const Divider(),
         deliverytype(context, Colors.blueGrey ,DeliveriesReadyPage(), 'Deliveries Ready'),
         deliverytype(context, Colors.blue ,DeliveriesInProgressPage(), 'Deliveries In Progress'),
         deliverytype(context, Colors.green, DeliveriesCompletedPage(), 'Deliveries Completed')
      ],
    );
  }
}

