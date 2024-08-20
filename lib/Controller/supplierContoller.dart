// ignore_for_file: use_super_parameters, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/supplier_bill_client.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:myshop/View/purchase/purchase_choice_item_supplier.dart';
import 'package:myshop/View/suppliers.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../Model/suppliers.dart';

class Suppliercontoller extends StatelessWidget {
  
   @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<Supplierlistprovider>().Suppliers.length,
      itemBuilder: (context, index) {
        Supplier supplier = context.watch<Supplierlistprovider>().Suppliers[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: inkWellsupplierdetails(context, supplier),
          
        );
      },
    );
  }
}


// show suppliersdetails 
Container supplierdetails(Supplier supplier){
    String itemsSupplied = supplier.list.map((item) => item.name).join(', ');
  return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Fond transparent
        border: Border.all(
          color: Colors.blue, // Couleur des bords
          width: 1.0, // Largeur des bords
        ),
        borderRadius: BorderRadius.circular(1.0), // Coins arrondis
      ),
     child: Column(
      children: [ 
        Row(
          children: [ 
            const Icon(
              Icons.person,
            ),
            Text(supplier.name,
            style: clienttextstyle(),)
          ],
        ),
        Row(
          children: [ 
            Text('contact : ',
             style: clienttextstyle()),
            Text(supplier.contact,
            style: clienttextstyle())
          ],
        ),
        Row(
          children: [ 
            Text('adress : ',
             style: clienttextstyle()),
            Text(supplier.adress??'',
            style: clienttextstyle())
          ],
        ),
        Row(
          children: [ 
            Text('email : ',
             style: clienttextstyle()),
            Text(supplier.email??'',
            style: clienttextstyle())
          ],
        ),
       Text('Items supplied : $itemsSupplied',
       style: clienttextstyle()),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [ 
           ElevatedButton(onPressed: (){}, child: const Text('new Order')),
          ElevatedButton(onPressed: (){}, child: const Text('Orders'))
        ],
       )
      ],
     ),
  );
}

// form supplier adder
 void showSimpleDialogAddSupplier(BuildContext context) {
    final TextEditingController textFieldController1 = TextEditingController();
    final TextEditingController textFieldController2 = TextEditingController();
    final TextEditingController textFieldController3 = TextEditingController();
    final TextEditingController textFieldController4 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Supplier'),
          content: Column(
            children: [ 
                  TextField(
                controller: textFieldController1,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: textFieldController2,
                decoration: const InputDecoration(
                  hintText: 'contact',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: textFieldController3,
                decoration: const InputDecoration(
                  hintText: 'adress',
                ),
              ),
               TextField(
                keyboardType: TextInputType.number,
                controller: textFieldController4,
                decoration: const InputDecoration(
                  hintText: 'email',
                ),
              ),
            ],
          ) ,
              
           
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // Traiter les valeurs des champs de texte
                String name = textFieldController1.text;
                String contact = textFieldController2.text;
                String adress = textFieldController3.text;
                String email = textFieldController4.text;
                int i= context.read<Supplierlistprovider>().Suppliers.length;
                Supplier S= Supplier(id: i, name: name, contact: contact, adress: adress, email: email,itemsdelivered :0, list: []);
                context.read<Supplierlistprovider>().addsup(S);
                if(context.read<itemsProvider>().globalItems.isNotEmpty){
                   Navigator.of(context).push(
                  MaterialPageRoute(
                     builder: (context) => ChooseItemsforSupp(item: S),
                      ),
                   ).then((_){
                          Navigator.of(context).pop();
                   });
                }
                else{ Navigator.of(context).pop();} 
                //context.read<itemsProvider>().addcat(I);
              },
            ),
          ],
        );
      },
    );
  }

  InkWell inkWellsup(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Supplierlist()),
            );
          },
    child: card(S),
  );
}
  InkWell inkWellsupplierdetails(BuildContext context,Supplier supplier){
    // String itemsSupplied = client.list.map((item) => item.name).join(', ');
  return InkWell(
    onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ClientList()),
            );*/
          },
    child: supplierdetails(supplier)
  );
}

List<Color> generateDistinctColors(List<Color> colors) {
  Random random = Random();
  
    // Generate random RGB values with significant differences
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);

    // Create a new color with the random RGB values
    Color color = Color.fromARGB(255, r, g, b);

    // Ensure the color is distinct enough from previously generated colors
    while (colors.any((c) => isTooSimilar(c, color))) {
      r = random.nextInt(256);
      g = random.nextInt(256);
      b = random.nextInt(256);
      color = Color.fromARGB(255, r, g, b);
    }

    colors.add(color);
  

  return colors;
}

bool isTooSimilar(Color c1, Color c2) {
  int threshold = 100; // Adjust this value to control similarity threshold
  return (c1.red - c2.red).abs() < threshold &&
         (c1.green - c2.green).abs() < threshold &&
         (c1.blue - c2.blue).abs() < threshold;
}