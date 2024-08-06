// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myshop/Model/iteems/item_category.dart';

class Itemdetailscontroller extends StatelessWidget {
  final Item item;


    const Itemdetailscontroller({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
        Positioned.fill(
              child: Image.asset(
                'images/wp2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            
              Column(
            
            children: [ 
              const Card(
                child: SizedBox(
                  height: 200,
                  width: 400,
                  //child: LineChartSample(),
                ),
              ),
              //const Divider(),
              const Padding(padding: EdgeInsets.only(top: 25.0)),
              
              ItemsDetails(item)
               
            ],
          )
            
          
      ],
      ),
      
    );
  }
}