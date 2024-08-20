// ignore_for_file: use_super_parameters, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:myshop/View/purchase/purchase_InProgress.dart';
import 'package:myshop/View/purchase/purchase_Piechart.dart';


class PurchasesView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const  Center(
            child: Text('Purchases'),
          ),
          backgroundColor: Colors.blueAccent,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.query_stats),
              ),
              Tab(
                icon: Icon(Icons.timelapse),
              ),
              Tab(
                icon: Icon(Icons.check_circle_outline),
              ),
             
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            PurchasePiechart(),
            PurchaseInprogress(),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}