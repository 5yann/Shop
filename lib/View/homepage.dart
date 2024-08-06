// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:myshop/Controller/home/homepagecontroller.dart';
import 'package:myshop/Model/deliveryModels/delivery_purchase.dart';
//import 'package:myshop/Controller/global_sell_graph_controller.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/supplier_bill_client.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});


   @override
  _HomepageState createState() => _HomepageState();

}

class _HomepageState extends State<Homepage>{

 
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       
drawer: drawer(),
appBar: homepageAppBar(),
       body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'images/wp2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               graphsells(),
              Row(
                
                children: [ 
                  Expanded(child:inkWellCategories(context,'Categories')),
                  Expanded(child:inkWellItems(context ,'Items')),        
                ],
              ),
              Row(
                
                children: [ 
                  Expanded(child:inkWell('Orders')),
                  Expanded(child:inkWellDelivery(context,'Deliveries')),        
                ],
              ),
             Row(
                
                children: [ 
                  Expanded(child:inkWellsup(context, 'Suppliers')),
                  Expanded(child:inkWellcl(context,'Clients')),        
                ],
              ),
              Row(
                
                children: [ 
                  Expanded(child:inkWell('Bills')),
                  Expanded(child:inkWell('Stories')),        
                ],
              ),
            ],
          )
        ],
       ),
      );
  }
}