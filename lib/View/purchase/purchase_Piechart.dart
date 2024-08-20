// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../Controller/purchase_Controller.dart';
class PurchasePiechart extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    final providerValue =context.watch<Supplierlistprovider>();
     return Scaffold(
      body: Stack(
        children: [
          wallpaper(),
          if(providerValue.isEmpty) PieChart(
              dataMap: providerValue.dataMap,
              chartType: ChartType.disc,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 40,
              chartRadius: MediaQuery.of(context).size.width ,
              //chartRadius: 300,
              colorList: providerValue.colors,
              ringStrokeWidth: 50,
              legendOptions: const LegendOptions(
              showLegends: true,
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              legendShape :BoxShape.circle,
              legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70
        ),
            ),
              )
              else const Center( 
                child:  Text('You dont have any supplier yet',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w900
                          ),) ,
              )
        ],
      )
     ) ;
  }
  
}

