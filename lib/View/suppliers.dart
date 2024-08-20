
import 'package:flutter/material.dart';
import 'package:myshop/Controller/supplierContoller.dart';

class Supplierlist extends StatelessWidget {
  const Supplierlist({super.key});





  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: const Text("My Suppliers"),
            backgroundColor: const Color.fromARGB(255, 7, 81, 255),
            actions: [
              IconButton(
              onPressed: (){
                //showSimpleDialogcat(context);
                showSimpleDialogAddSupplier(context);
              }, 
              icon:const  Icon(Icons.add))
            ],
          ),
          body:Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'images/wp2.jpg',
                fit: BoxFit.cover,
              ),
            ),
             Suppliercontoller()
            ]),
        )
    ;
  }
}