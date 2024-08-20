// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myshop/Model/homepagewidgets.dart';
import 'package:myshop/Model/suppliers.dart';
import 'package:myshop/Providers/categoriesProvider.dart';
import 'package:myshop/Providers/itemsProvider.dart';
import 'package:myshop/Providers/purchase_Provider.dart';
import 'package:myshop/Providers/supplierListProvider.dart';
import 'package:myshop/View/items/itemscatlistpage.dart';
import 'package:myshop/View/purchase/purchase_choice_item_supplier.dart';
import 'package:provider/provider.dart';

class Item{
 final int id;
 final String name;
 final String? description;
 final String category;
 double price ;
 double Pprice ;
 double quantity;
 late List<Supplier> suppliers;
 Item({required this.id,
 required this.name,
  required this.description,
 required this.category,
 required this.price,
 required this.Pprice,
 required this.quantity,
 required this.suppliers});

   Map<String, dynamic> toMap() {
    return {
     'id':id,
     'name':name,
     'description':description,
     'category':category,
     'price':price,
     'Pprice':Pprice,
     'quantity':quantity,
     'suppliers':suppliers
    };
  }

   factory Item.fromDocument(DocumentSnapshot doc) {
    return Item(
      id: doc['id'],
      name:doc['name'],
      description: doc['description'],
      category: doc['category'],
      price: doc['price'],
      Pprice: doc['Pprice'],
      quantity: doc['quantity'],
      suppliers:doc['suppliers'],
    );
  }

}

class Category{
 final String categoryname;
 double total;
 Category({required this.categoryname,
 required this.total});

 Map<String, dynamic> toMap() {
    return {
    'total':total,
    };
  }

  factory Category.fromDocument(DocumentSnapshot doc) {
    return Category(
      categoryname:doc['categoryname'],
      total:doc['total']
    );
  }
}
// add category
 void showSimpleDialogcat(BuildContext context) {
    final TextEditingController textFieldController1 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a category'),
          content: TextField(
                controller: textFieldController1,
                decoration: const InputDecoration(
                  hintText: 'CategoryName',
                ),
              ),
              
           
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
                String value1 = textFieldController1.text;
                Category C = Category(categoryname: value1, total: 0);
                context.read<CategoriesProvider>().addcat(C);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  InkWell inkWellitem(BuildContext context,String S){

  return InkWell(
    onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Itemscatlistpage(text: S)),
            );
          },
    child: card(S),
  );
}

 void showSimpleDialogAddItemInCat(BuildContext context, String s) {
    final TextEditingController textFieldController1 = TextEditingController();
    final TextEditingController textFieldController2 = TextEditingController();
    final TextEditingController textFieldController3 = TextEditingController();
    final TextEditingController textFieldController4 = TextEditingController();
    final TextEditingController textFieldController5 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add an Item'),
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
                  hintText: 'description',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: textFieldController3,
                decoration: const InputDecoration(
                  hintText: ' sale price',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: textFieldController5,
                decoration: const InputDecoration(
                  hintText: ' purchase price',
                ),
              ),
               TextField(
                keyboardType: TextInputType.number,
                controller: textFieldController4,
                decoration: const InputDecoration(
                  hintText: 'Quantity',
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
                String description = textFieldController2.text;
                String price = textFieldController3.text;
                String pprice = textFieldController3.text;
                String quantity = textFieldController4.text;
                int i= context.read<itemsProvider>().globalItems.length;
                Item I = Item(id: i, name: name, description: description, category: s, price: double.parse(price),Pprice: double.parse(pprice), quantity:double.parse(quantity),suppliers:[] );
                //ChooseSuppforItems(I, context);
                //context.read<itemsProvider>().addcat(I);
               context.read<itemsProvider>().addglob(I);
               if(context.read<Supplierlistprovider>().Suppliers.isNotEmpty)
               {Navigator.of(context).push(
                  MaterialPageRoute(
                     builder: (context) => ChooseSuppforItem(item: I),
                      ),
                   ).then((_){
                          Navigator.of(context).pop();
                   });
                }
                else{
                  Navigator.of(context).pop();
                }
                
              },
            ),
          ],
        );
      },
    );
  }


  void UpdateOrRemoveItemAlertdialog(BuildContext context, Item I){
     showDialog(context: context,
      builder: (BuildContext context){
         return AlertDialog(
      actions: <Widget>[
            TextButton(
              child: const Text('modify'),
              onPressed: () {
                //Navigator.of(context).pop();
              },
            ),
             TextButton(
              child: const Text('remove'),
              onPressed: () {
                context.read<itemsProvider>().removeglob(I.id);
                Navigator.of(context).pop();
              },
            ),
      ],
    );
      });
  }

  // show an Item details

 Column ItemsDetails(Item I){
     return   Column(
          children: [
            detalitms('Name', I.name),
            detalitms('Category', I.category),
            detalitms('Description', I.description??''),
            detalitms('Price', I.price.toString()),
            detalitms('Quantity', I.quantity.toString())
          ],
        
     );
  }

  Row detalitms(String s1,String s2){
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('$s1 :',
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: Colors.amber
        ),),
        Text(s2,
        
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 25,
          color: Colors.amber
        )
        )
      ],
     );
  }

 Supplier getOneSupp(Item item,BuildContext context){
  Supplier s= item.suppliers[0];
  final radioModel=context.read<Purchase_Provider>();
  showDialog(context: context, builder: (BuildContext ctx){
    return AlertDialog(
     title: Column(
      children: [
        Text('Which of these suppliers would you like to place the order with for ${item.name}?'),
           ListView.builder(
        itemCount: item.suppliers.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(item.suppliers[index].name),
            value: index,
            groupValue: radioModel.selectSup,
            onChanged: (int? value) {
              if (value != null) {
                radioModel.selectRadiosup(value);
                s=item.suppliers[radioModel.selectSup??0];
              }
            },
          );
        },
      ),
      TextButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child:const Text('ok'))
      ],
     ),
  );
  });
 
    return s; 
 }