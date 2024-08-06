

// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//import 'package:myshop/Model/delivery_purchase.dart';

class GraphAllSells extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<double> _deliveriesDone = [2,4,6,1];
  List<FlSpot> spots =[
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 10),
                    FlSpot(3, 7),
                    FlSpot(4, 12)
  ];
  

   List<FlSpot> getSalesSpots(List<double> sales ) {
    for (int i = 0; i < _deliveriesDone.length; i++) {
      spots.add(FlSpot(i.toDouble(), sales[i]));
    }
    return spots;
  }
  /// Adds [item] to cart.
  void add(double item) {
    _deliveriesDone.add(item);
    spots=getSalesSpots(_deliveriesDone);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}